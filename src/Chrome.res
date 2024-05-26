open Types.ChromeTypes

@val external setLocalStorage: stateKv => promise<unit> = "chrome.storage.local.set"
@val external getLocalStorage: string => promise<stateKv> = "chrome.storage.local.get"

@val external runtimeOnInstall: (unit => unit) => unit = "chrome.runtime.onInstalled.addListener"
@val external navigationOnComplete: (navEvent => unit) => unit = "chrome.webNavigation.onCompleted.addListener"
@val external tabsOnActivated: (activeInfo => unit) => unit = "chrome.tabs.onActivated.addListener"
@val external tabsOnRemoved: ((int, tabRemoveInfo) => unit) => unit = "chrome.tabs.onRemoved.addListener"