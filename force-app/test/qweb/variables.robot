*** Settings ***
Documentation               List of all the common webelements used

*** Variables ***
${INPUT_FIELD_WEBELEMENT}                               xpath\=//label[text()\='LABEL']/parent::lightning-input//input
${APPS_WEBELEMENT}                                      xpath\=//h3[normalize-space()\='Apps']
${SEARCH_APPS_WEBELEMENT}                               xpath\=//input[@placeholder\="Search apps and items..."]
${OBJECT_WEBELEMENT}                                    xpath\=//*[@data-label\='OBJECT']
${VERIFY_OBJECT_WELELEMENT}                             xpath\=//li/span[text()="OBJECT"]
${USER_WEBELEMENT}                                      xpath\=//h1//a[@class\='profile-link-label']
${REFRESH_BUTTON_WEBELEMENT}                            xpath\=//button[@title\='Refresh']//lightning-primitive-icon
${SEARCHED_RECORD_WEBELEMENT}                           xpath\=//tr[1]//a[normalize-space()\='RECORD']
${CANCEL_BUTTON_WEBELEMENT}                             xpath\=//button[@title\='Cancel']
${SELECT_RECORD_WEBELEMENT}                             xpath\=//tr[1]/td[1]//a[text()\='RECORD']
${TOAST_MESSAGE_WEBELEMENT}                             xpath\=//span[@class\="toastMessage slds-text-heading--small forceActionsText"]/a/div
${SHOW_ACTIONS_WEBELEMENT}                              xpath\=//tbody//span[contains(text(),'Show')]/ancestor::a
${SHOW_ACTION_WEBELEMENT}                               xpath\=(//tbody//span[contains(text(),'Show')]/ancestor::a)[last()]
${NEW_BUTTON}                                           xpath\=//button[@title='New']
${RECORDCOUNT_WEBELEMENT}                               xpath\=//span[contains(@class, 'row-number')]
${EDIT_STORIES}                                         xpath\=//button[@title\='Edit Stories']
${CHECKBOX_ELEMENT}                                     xpath\=//span[text()\="Select Item 1"]//parent::label[@class\='slds-checkbox__label']
${CANCEL_BUTTON}                                        xpath\=(//button[@title\='Cancel'])[2]
${STATUS_FIELD_WEBELEMENT}                              xpath\=//span[text()\='Status']/ancestor::flexipage-field//lightning-formatted-text