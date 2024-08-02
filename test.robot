*** Settings ***
Library           PandasLibrary
Library           ExcelLibrary

*** Variables ***
${EXCEL_FILE_1}    path/to/your/first_file.xlsx
${EXCEL_FILE_2}    path/to/your/second_file.xlsx

*** Test Cases ***
Search Data Across Multiple Excel Files
    ${data1}=    Read Excel Data    ${EXCEL_FILE_1}
    ${data2}=    Read Excel Data    ${EXCEL_FILE_2}
    ${search_term}=    Your Search Term
    ${found1}=    Search Data    ${data1}    ${search_term}
    ${found2}=    Search Data    ${data2}    ${search_term}
    Log    Data found in file 1: ${found1}
    Log    Data found in file 2: ${found2}

*** Keywords ***
Read Excel Data
    [Arguments]    ${file_path}
    Open Excel File    ${file_path}
    ${data}=    Read Worksheet Data    sheet_name=Sheet1
    Close Excel File
    [Return]    ${data}

Search Data
    [Arguments]    ${data}    ${search_term}
    ${result}=    Evaluate    any(${search_term} in str(row) for row in ${data})
    [Return]    ${result}
