Feature: [SF-SEF-DAU] Effectivity Satellites without automatic end-dating

  @fixture.eff_satellite_status
  Scenario: [SF-SEF-DAU-01] Link is Changed with auto end-dating off
    Given the EFF_SAT eff_sat_status is already populated with data
      | CUSTOMER_ORDER_PK  | CUSTOMER_PK | ORDER_PK   | STATUS | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1000\|\|AAA') | md5('1000') | md5('AAA') | TRUE   | 2020-01-09     | 2020-01-10 | orders |
      | md5('2000\|\|BBB') | md5('2000') | md5('BBB') | TRUE   | 2020-01-09     | 2020-01-10 | orders |
      | md5('3000\|\|CCC') | md5('3000') | md5('CCC') | TRUE   | 2020-01-09     | 2020-01-10 | orders |
    And the RAW_STAGE table contains data
      | CUSTOMER_ID | ORDER_ID | START_DATE | END_DATE   | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | 4000        | CCC      | 2020-01-11 | 9999-12-31 | 2020-01-11     | 2020-01-12 | orders |
    And I stage the STG_CUSTOMER data
    When I load the EFF_SAT eff_sat_status
    Then the EFF_SAT table should contain expected data
      | CUSTOMER_ORDER_PK  | CUSTOMER_PK | ORDER_PK   | STATUS | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1000\|\|AAA') | md5('1000') | md5('AAA') | TRUE   | 2020-01-09     | 2020-01-10 | orders |
      | md5('2000\|\|BBB') | md5('2000') | md5('BBB') | TRUE   | 2020-01-09     | 2020-01-10 | orders |
      | md5('3000\|\|CCC') | md5('3000') | md5('CCC') | TRUE   | 2020-01-09     | 2020-01-10 | orders |
      | md5('4000\|\|CCC') | md5('4000') | md5('CCC') | TRUE   | 2020-01-11     | 2020-01-12 | orders |

  @fixture.eff_satellite_status
  Scenario: [SF-SEF-DAU-02] 2 loads, Link is Changed Back Again with auto end-dating off
    Given the EFF_SAT eff_sat_status is already populated with data
      | CUSTOMER_ORDER_PK  | CUSTOMER_PK | ORDER_PK   | STATUS | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1000\|\|AAA') | md5('1000') | md5('AAA') | TRUE   | 2020-01-09     | 2020-01-10 | orders |
      | md5('2000\|\|BBB') | md5('2000') | md5('BBB') | TRUE   | 2020-01-09     | 2020-01-10 | orders |
      | md5('3000\|\|CCC') | md5('3000') | md5('CCC') | TRUE   | 2020-01-09     | 2020-01-10 | orders |
      | md5('3000\|\|CCC') | md5('3000') | md5('CCC') | FALSE  | 2020-01-11     | 2020-01-12 | orders |
      | md5('4000\|\|CCC') | md5('4000') | md5('CCC') | TRUE   | 2020-01-11     | 2020-01-12 | orders |
    And the RAW_STAGE table contains data
      | CUSTOMER_ID | ORDER_ID | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | 5000        | CCC      | 2020-01-12     | 2020-01-13 | orders |
    And I stage the STG_CUSTOMER data
    When I load the EFF_SAT eff_sat_status
    Then the EFF_SAT table should contain expected data
      | CUSTOMER_ORDER_PK  | CUSTOMER_PK | ORDER_PK   | STATUS | EFFECTIVE_FROM | LOAD_DATE  | SOURCE |
      | md5('1000\|\|AAA') | md5('1000') | md5('AAA') | TRUE   | 2020-01-09     | 2020-01-10 | orders |
      | md5('2000\|\|BBB') | md5('2000') | md5('BBB') | TRUE   | 2020-01-09     | 2020-01-10 | orders |
      | md5('3000\|\|CCC') | md5('3000') | md5('CCC') | TRUE   | 2020-01-09     | 2020-01-10 | orders |
      | md5('3000\|\|CCC') | md5('3000') | md5('CCC') | FALSE  | 2020-01-11     | 2020-01-12 | orders |
      | md5('4000\|\|CCC') | md5('4000') | md5('CCC') | TRUE   | 2020-01-11     | 2020-01-12 | orders |
      | md5('5000\|\|CCC') | md5('5000') | md5('CCC') | TRUE   | 2020-01-12     | 2020-01-13 | orders |