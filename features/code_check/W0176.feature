Feature: W0176

  W0176 detects that `long' value is converted into `unsigned long long' value.

  Scenario: implicit conversion in initialization
    Given a target source named "fixture.c" with:
      """
      void foo(long a)
      {
          unsigned long long b = a; /* W0176 */
      }
      """
    When I successfully run `adlint fixture.c` on noarch
    Then the output should exactly match with:
      | mesg  | line | column |
      | W0117 | 1    | 6      |
      | W0176 | 3    | 28     |
      | W0100 | 3    | 24     |
      | W0104 | 1    | 15     |
      | W0834 | 3    | 5      |
      | W0628 | 1    | 6      |

  Scenario: explicit conversion in initialization
    Given a target source named "fixture.c" with:
      """
      void foo(long a)
      {
          unsigned long long b = (unsigned long long) a; /* OK */
      }
      """
    When I successfully run `adlint fixture.c` on noarch
    Then the output should exactly match with:
      | mesg  | line | column |
      | W0117 | 1    | 6      |
      | W0608 | 3    | 28     |
      | C1000 |      |        |
      | C1006 | 1    | 15     |
      | W0100 | 3    | 24     |
      | W0104 | 1    | 15     |
      | W0834 | 3    | 29     |
      | W0834 | 3    | 5      |
      | W0628 | 1    | 6      |

  Scenario: implicit conversion in assignment
    Given a target source named "fixture.c" with:
      """
      void foo(long a)
      {
          unsigned long long b;
          b = a; /* W0176 */
      }
      """
    When I successfully run `adlint fixture.c` on noarch
    Then the output should exactly match with:
      | mesg  | line | column |
      | W0117 | 1    | 6      |
      | W0176 | 4    | 9      |
      | W0100 | 3    | 24     |
      | W0104 | 1    | 15     |
      | W0834 | 3    | 5      |
      | W0628 | 1    | 6      |

  Scenario: explicit conversion in assignment
    Given a target source named "fixture.c" with:
      """
      void foo(long a)
      {
          unsigned long long b;
          b = (unsigned long long) a; /* OK */
      }
      """
    When I successfully run `adlint fixture.c` on noarch
    Then the output should exactly match with:
      | mesg  | line | column |
      | W0117 | 1    | 6      |
      | W0608 | 4    | 9      |
      | C1000 |      |        |
      | C1006 | 1    | 15     |
      | W0100 | 3    | 24     |
      | W0104 | 1    | 15     |
      | W0834 | 3    | 5      |
      | W0834 | 4    | 10     |
      | W0628 | 1    | 6      |

  Scenario: implicit conversion in function call
    Given a target source named "fixture.c" with:
      """
      extern void bar(unsigned long long);

      void foo(long a)
      {
          bar(a); /* W0176 */
      }
      """
    When I successfully run `adlint fixture.c` on noarch
    Then the output should exactly match with:
      | mesg  | line | column |
      | W0118 | 1    | 13     |
      | W0117 | 3    | 6      |
      | W0176 | 5    | 9      |
      | W0104 | 3    | 15     |
      | W0834 | 1    | 17     |
      | W0628 | 3    | 6      |

  Scenario: explicit conversion in function call
    Given a target source named "fixture.c" with:
      """
      extern void bar(unsigned long long);

      void foo(long a)
      {
          bar((unsigned long long) a); /* OK */
      }
      """
    When I successfully run `adlint fixture.c` on noarch
    Then the output should exactly match with:
      | mesg  | line | column |
      | W0118 | 1    | 13     |
      | W0117 | 3    | 6      |
      | W0608 | 5    | 9      |
      | C1000 |      |        |
      | C1006 | 3    | 15     |
      | W0104 | 3    | 15     |
      | W0834 | 1    | 17     |
      | W0834 | 5    | 10     |
      | W0628 | 3    | 6      |

  Scenario: implicit conversion in function return
    Given a target source named "fixture.c" with:
      """
      unsigned long long foo(long a)
      {
          return a; /* W0176 */
      }
      """
    When I successfully run `adlint fixture.c` on noarch
    Then the output should exactly match with:
      | mesg  | line | column |
      | W0117 | 1    | 20     |
      | W0176 | 3    | 12     |
      | W0312 | 3    | 5      |
      | W0104 | 1    | 29     |
      | W0834 | 1    | 1      |
      | W0628 | 1    | 20     |

  Scenario: explicit conversion in function return
    Given a target source named "fixture.c" with:
      """
      unsigned long long foo(long a)
      {
          return (unsigned long long) a; /* OK */
      }
      """
    When I successfully run `adlint fixture.c` on noarch
    Then the output should exactly match with:
      | mesg  | line | column |
      | W0117 | 1    | 20     |
      | W0608 | 3    | 12     |
      | C1000 |      |        |
      | C1006 | 1    | 29     |
      | W0104 | 1    | 29     |
      | W0834 | 1    | 1      |
      | W0834 | 3    | 13     |
      | W0628 | 1    | 20     |
