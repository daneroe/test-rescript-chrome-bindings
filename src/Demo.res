open Promise

// Would be defined in separate "types" file
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

type tabRemoveInfo = {
  isWindowClosing: bool,
  windowId: int,
}

type stateKv = {state: string}

// Would be defined in separate "bindings" file"
@val external setLocalStorage: stateKv => promise<unit> = "chrome.storage.local.set"
@val external getLocalStorage: string => promise<stateKv> = "chrome.storage.local.get"
@val external runtimeOnInstall: (unit => unit) => unit = "chrome.runtime.onInstalled.addListener"
@val external navigationOnComplete: (navEvent => unit) => unit = "chrome.webNavigation.onCompleted.addListener"
@val external tabsOnActivated: (activeInfo => unit) => unit = "chrome.tabs.onActivated.addListener"
@val external tabsOnRemoved: ((int, tabRemoveInfo) => unit) => unit = "chrome.tabs.onRemoved.addListener"

runtimeOnInstall(_ => {
  Console.log("Initialising state then retrieving it")
  setLocalStorage({state: "My State Value"})
  ->thenResolve(_ => getLocalStorage("state")->thenResolve(res => Console.log(res.state)))
  ->ignore // need this as have indicated in the bindings that these callbacks return unit (F#-y)
})

navigationOnComplete(navEvent => {
  Console.log("Naving")
  Console.log(navEvent)
})

tabsOnActivated(tabInfo => {
  Console.log("Tabbing")
  Console.log(tabInfo)
})

tabsOnRemoved((id, tabRemoveInfo) => {
  Console.log("Closing")
  Console.log(id)
  Console.log(tabRemoveInfo)
})
