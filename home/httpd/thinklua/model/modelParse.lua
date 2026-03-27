function handleViewRequest(modelName,fileEvn)
local modelPath = "modules."..modelName
package.loaded[modelPath] = nil
local page = require(modelPath)
package.loaded[modelPath] = nil
page:buildView(fileEvn)
end
function handleDataRequest(modelName)
local modelPath = "modules."..modelName
package.loaded[modelPath] = nil
local page = require(modelPath)
package.loaded[modelPath] = nil
page:dataRun()
end
return{
handleViewRequest = handleViewRequest,
handleDataRequest = handleDataRequest
}
