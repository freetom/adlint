Feature: W0237

  W0237 detects that `long double' value is converted into `long' value.

  Scenario: implicit conversion in initialization
    Given a target source named "fixture.c" with:
      """
      void foo(long double a)
      {
          long b = a; /* W0237 */
      }
      """
    When I successfully run `adlint fixture.c` on noarch
    Then the output should exactly match with:
      | mesg  | line | column |
      | W0117 | 1    | 6      |
      | W0237 | 3    | 14     |
      | W0100 | 3    | 10     |
      | W0104 | 1    | 22     |
      | W0628 | 1    | 6      |

  Scenario: explicit conversion in initialization
    Given a target source named "fixture.c" with:
      """
      void foo(long double a)
      {
          long b = (long) a; /* OK */
      }
      """
    When I successfully run `adlint fixture.c` on noarch
    Then the output should exactly match with:
      | mesg  | line | column |
      | W0117 | 1    | 6      |
      | W0100 | 3    | 10     |
      | W0104 | 1    | 22     |
      | W0628 | 1    | 6      |

  Scenario: implicit conversion in assignment
    Given a target source named "fixture.c" with:
      """
      void foo(long double a)
      {
          long b;
          b = a; /* W0237 */
      }
      """
    When I successfully run `adlint fixture.c` on noarch
    Then the output should exactly match with:
      | mesg  | line | column |
      | W0117 | 1    | 6      |
      | W0237 | 4    | 9      |
      | W0100 | 3    | 10     |
      | W0104 | 1    | 22     |
      | W0628 | 1    | 6      |

  Scenario: explicit conversion in assignment
    Given a target source named "fixture.c" with:
      """
      void foo(long double a)
      {
          long b;
          b = (long) a; /* OK */
      }
      """
    When I successfully run `adlint fixture.c` on noarch
    Then the output should exactly match with:
      | mesg  | line | column |
      | W0117 | 1    | 6      |
      | W0100 | 3    | 10     |
      | W0104 | 1    | 22     |
      | W0628 | 1    | 6      |

  Scenario: implicit conversion in function call
    Given a target source named "fixture.c" with:
      """
      extern void bar(long);

      void foo(long double a)
      {
          bar(a); /* W0237 */
      }
      """
    When I successfully run `adlint fixture.c` on noarch
    Then the output should exactly match with:
      | mesg  | line | column |
      | W0118 | 1    | 13     |
      | W0117 | 3    | 6      |
      | W0237 | 5    | 9      |
      | W0104 | 3    | 22     |
      | W0628 | 3    | 6      |

  Scenario: explicit conversion in function call
    Given a target source named "fixture.c" with:
      """
      extern void bar(long);

      void foo(long double a)
      {
          bar((long) a); /* OK */
      }
      """
    When I successfully run `adlint fixture.c` on noarch
    Then the output should exactly match with:
      | mesg  | line | column |
      | W0118 | 1    | 13     |
      | W0117 | 3    | 6      |
      | W0104 | 3    | 22     |
      | W0628 | 3    | 6      |

  Scenario: implicit conversion in function return
    Given a target source named "fixture.c" with:
      """
      long foo(long double a)
      {
          return a; /* W0237 */
      }
      """
    When I successfully run `adlint fixture.c` on noarch
    Then the output should exactly match with:
      | mesg  | line | column |
      | W0117 | 1    | 6      |
      | W0237 | 3    | 12     |
      | W0373 | 3    | 5      |
      | W0104 | 1    | 22     |
      | W0628 | 1    | 6      |

  Scenario: explicit conversion in function return
    Given a target source named "fixture.c" with:
      """
      long foo(long double a)
      {
          return (long) a; /* OK */
      }
      """
    When I successfully run `adlint fixture.c` on noarch
    Then the output should exactly match with:
      | mesg  | line | column |
      | W0117 | 1    | 6      |
      | W0104 | 1    | 22     |
      | W0628 | 1    | 6      |
