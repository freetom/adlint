Feature: W0180

  W0180 detects that `long long' value is converted into `unsigned long' value.

  Scenario: implicit conversion in initialization
    Given a target source named "fixture.c" with:
      """
      void foo(long long a)
      {
          unsigned long b = a; /* W0180 */
      }
      """
    When I successfully run `adlint fixture.c` on noarch
    Then the output should exactly match with:
      | mesg  | line | column |
      | W0117 | 1    | 6      |
      | W0180 | 3    | 23     |
      | W0100 | 3    | 19     |
      | W0104 | 1    | 20     |
      | W0834 | 1    | 10     |
      | W0628 | 1    | 6      |

  Scenario: explicit conversion in initialization
    Given a target source named "fixture.c" with:
      """
      void foo(long long a)
      {
          unsigned long b = (unsigned long) a; /* OK */
      }
      """
    When I successfully run `adlint fixture.c` on noarch
    Then the output should exactly match with:
      | mesg  | line | column |
      | W0117 | 1    | 6      |
      | W0608 | 3    | 23     |
      | C1000 |      |        |
      | C1006 | 1    | 20     |
      | W0100 | 3    | 19     |
      | W0104 | 1    | 20     |
      | W0834 | 1    | 10     |
      | W0628 | 1    | 6      |

  Scenario: implicit conversion in assignment
    Given a target source named "fixture.c" with:
      """
      void foo(long long a)
      {
          unsigned long b;
          b = a; /* W0180 */
      }
      """
    When I successfully run `adlint fixture.c` on noarch
    Then the output should exactly match with:
      | mesg  | line | column |
      | W0117 | 1    | 6      |
      | W0180 | 4    | 9      |
      | W0100 | 3    | 19     |
      | W0104 | 1    | 20     |
      | W0834 | 1    | 10     |
      | W0628 | 1    | 6      |

  Scenario: explicit conversion in assignment
    Given a target source named "fixture.c" with:
      """
      void foo(long long a)
      {
          unsigned long b;
          b = (unsigned long) a; /* OK */
      }
      """
    When I successfully run `adlint fixture.c` on noarch
    Then the output should exactly match with:
      | mesg  | line | column |
      | W0117 | 1    | 6      |
      | W0608 | 4    | 9      |
      | C1000 |      |        |
      | C1006 | 1    | 20     |
      | W0100 | 3    | 19     |
      | W0104 | 1    | 20     |
      | W0834 | 1    | 10     |
      | W0628 | 1    | 6      |

  Scenario: implicit conversion in function call
    Given a target source named "fixture.c" with:
      """
      extern void bar(unsigned long);

      void foo(long long a)
      {
          bar(a); /* W0180 */
      }
      """
    When I successfully run `adlint fixture.c` on noarch
    Then the output should exactly match with:
      | mesg  | line | column |
      | W0118 | 1    | 13     |
      | W0117 | 3    | 6      |
      | W0180 | 5    | 9      |
      | W0104 | 3    | 20     |
      | W0834 | 3    | 10     |
      | W0628 | 3    | 6      |

  Scenario: explicit conversion in function call
    Given a target source named "fixture.c" with:
      """
      extern void bar(unsigned long);

      void foo(long long a)
      {
          bar((unsigned long) a); /* OK */
      }
      """
    When I successfully run `adlint fixture.c` on noarch
    Then the output should exactly match with:
      | mesg  | line | column |
      | W0118 | 1    | 13     |
      | W0117 | 3    | 6      |
      | W0608 | 5    | 9      |
      | C1000 |      |        |
      | C1006 | 3    | 20     |
      | W0104 | 3    | 20     |
      | W0834 | 3    | 10     |
      | W0628 | 3    | 6      |

  Scenario: implicit conversion in function return
    Given a target source named "fixture.c" with:
      """
      unsigned long foo(long long a)
      {
          return a; /* W0180 */
      }
      """
    When I successfully run `adlint fixture.c` on noarch
    Then the output should exactly match with:
      | mesg  | line | column |
      | W0117 | 1    | 15     |
      | W0180 | 3    | 12     |
      | W0316 | 3    | 5      |
      | W0104 | 1    | 29     |
      | W0834 | 1    | 19     |
      | W0628 | 1    | 15     |

  Scenario: explicit conversion in function return
    Given a target source named "fixture.c" with:
      """
      unsigned long foo(long long a)
      {
          return (unsigned long) a; /* OK */
      }
      """
    When I successfully run `adlint fixture.c` on noarch
    Then the output should exactly match with:
      | mesg  | line | column |
      | W0117 | 1    | 15     |
      | W0608 | 3    | 12     |
      | C1000 |      |        |
      | C1006 | 1    | 29     |
      | W0104 | 1    | 29     |
      | W0834 | 1    | 19     |
      | W0628 | 1    | 15     |
