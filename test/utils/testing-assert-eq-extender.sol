// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Test} from "forge-std/Test.sol";

import {Duration} from "contracts/types/Duration.sol";
import {Timestamp} from "contracts/types/Timestamp.sol";
import {PercentD16} from "contracts/types/PercentD16.sol";

import {ProposalStatus} from "contracts/EmergencyProtectedTimelock.sol";
import {State as DualGovernanceState} from "contracts/DualGovernance.sol";

contract TestingAssertEqExtender is Test {
    struct Balances {
        uint256 stETHAmount;
        uint256 stETHShares;
        uint256 wstETHAmount;
        uint256 wstETHShares;
    }

    function assertEq(Duration a, Duration b) internal {
        assertEq(uint256(Duration.unwrap(a)), uint256(Duration.unwrap(b)));
    }

    function assertEq(Timestamp a, Timestamp b) internal {
        assertEq(uint256(Timestamp.unwrap(a)), uint256(Timestamp.unwrap(b)));
    }

    function assertEq(ProposalStatus a, ProposalStatus b) internal {
        assertEq(uint256(a), uint256(b));
    }

    function assertEq(ProposalStatus a, ProposalStatus b, string memory message) internal {
        assertEq(uint256(a), uint256(b), message);
    }

    function assertEq(DualGovernanceState a, DualGovernanceState b) internal {
        assertEq(uint256(a), uint256(b));
    }

    function assertEq(Balances memory b1, Balances memory b2, uint256 sharesEpsilon) internal {
        assertEq(b1.wstETHShares, b2.wstETHShares);
        assertEq(b1.wstETHAmount, b2.wstETHAmount);

        assertApproxEqAbs(b1.stETHShares, b2.stETHShares, sharesEpsilon);
        assertApproxEqAbs(b1.stETHAmount, b2.stETHAmount, sharesEpsilon);
    }

    function assertEq(PercentD16 a, PercentD16 b) internal {
        assertEq(PercentD16.unwrap(a), PercentD16.unwrap(b));
    }
}
