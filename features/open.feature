Feature: Open luks

  Scenario: open a list of targets
    Given there is a key for all test Partitions
    When I run arver in test mode with arguments "-t location2,virtmachine1 --open"
    Then I should see "Trying to open /location1/machine1_1.example.tld/virtmachine1"
    And I should see "Trying to open /location2/machine2/virt1_rootfs"
    And I should see "Trying to open /location2/machine2/virt2_rootfs"
    And I should see "Trying to open /location2/machine1/virt2_srv"
    And I should see "Trying to open /location2/machine1/virt1_rootfs"

  Scenario: old keys can be used
    Given there is an unpadded keyfile
    When I run arver in test mode with arguments "-t virtmachine1 --open"
    Then I should see "Warning: you are using deprecated unpadded keyfiles. Please run garbage collect!"
    And I should see "Trying to open /location1/machine1_1.example.tld/virtmachine1"
