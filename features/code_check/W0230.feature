Feature: W0230

  W0230 detects that `long double' value is converted into `char' value.

  Scenario: implicit conversion in initialization
    Given a target source named "fixture.c" with:
      """
      void foo(long double a)
      {
          char b = a; /* W0230 */
      }
      """
    When I successfully run `adlint fixture.c` on noarch
    Then the output should exactly match with:
      | mesg  | line | column |
      | W0117 | 1    | 6      |
      | W0230 | 3    | 14     |
      | W0100 | 3    | 10     |
      | W0104 | 1    | 22     |
      | W0628 | 1    | 6      |

  Scenario: explicit conversion in initialization
    Given a target source named "fixture.c" with:
      """
      void foo(long double a)
      {
          char b = (char) a; /* OK */
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
          char b;
          b = a; /* W0230 */
      }
      """
    When I successfully run `adlint fixture.c` on noarch
    Then the output should exactly match with:
      | mesg  | line | column |
      | W0117 | 1    | 6      |
      | W0230 | 4    | 9      |
      | W0100 | 3    | 10     |
      | W0104 | 1    | 22     |
      | W0628 | 1    | 6      |

  Scenario: explicit conversion in assignment
    Given a target source named "fixture.c" with:
      """
      void foo(long double a)
      {
          char b;
          b = (char) a; /* OK */
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
      extern void bar(char);

      void foo(long double a)
      {
          bar(a); /* W0230 */
      }
      """
    When I successfully run `adlint fixture.c` on noarch
    Then the output should exactly match with:
      | mesg  | line | column |
      | W0118 | 1    | 13     |
      | W0117 | 3    | 6      |
      | W0230 | 5    | 9      |
      | W0104 | 3    | 22     |
      | W0628 | 3    | 6      |

  Scenario: explicit conversion in function call
    Given a target source named "fixture.c" with:
      """
      extern void bar(char);

      void foo(long double a)
      {
          bar((char) a); /* OK */
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
      char foo(long double a)
      {
          return a; /* W0230 */
      }
      """
    When I successfully run `adlint fixture.c` on noarch
    Then the output should exactly match with:
      | mesg  | line | column |
      | W0117 | 1    | 6      |
      | W0230 | 3    | 12     |
      | W0366 | 3    | 5      |
      | W0104 | 1    | 22     |
      | W0628 | 1    | 6      |

  Scenario: explicit conversion in function return
    Given a target source named "fixture.c" with:
      """
      char foo(long double a)
      {
          return (char) a; /* OK */
      }
      """
    When I successfully run `adlint fixture.c` on noarch
    Then the output should exactly match with:
      | mesg  | line | column |
      | W0117 | 1    | 6      |
      | W0104 | 1    | 22     |
      | W0628 | 1    | 6      |
