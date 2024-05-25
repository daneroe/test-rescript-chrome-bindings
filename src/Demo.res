open Promise

type activeInfo = {
  tabId: int,
  windowId: int,
}

type navEvent = {
  documentId: string,
  documentLifecycle: string,
  frameId: int,
  parentDocumentId: string,
  parentFrameId: int,
  processId: int,
  tabId: int,
  timeStamp: float,
  url: string,
}

@val external chrome: 'a = "chrome"

let setStorage = (val): promise<unit> => chrome["storage"]["local"]["set"](val)
let getStorage = (key): promise<'a> => chrome["storage"]["local"]["get"](key)

chrome["runtime"]["onInstalled"]["addListener"](_ => {
  Console.log("Initialising then retrieving state")
  setStorage({"state": "My State Value"})
  ->thenResolve(_ => getStorage("state"))
  ->thenResolve(res => Console.log(res))
})

chrome["webNavigation"]["onCompleted"]["addListener"]((navEvent: navEvent) => {
  Console.log("Naving")
  Console.log(navEvent.timeStamp)
})

chrome["tabs"]["onActivated"]["addListener"]((tabInfo: activeInfo) => {
  Console.log("Tabbing")
  Console.log(tabInfo.tabId)
  Console.log(tabInfo.windowId)
})
