// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {EnumerableProposals, Proposal} from "../libraries/EnumerableProposals.sol";

contract ProposalsList {
    using EnumerableProposals for EnumerableProposals.Bytes32ToProposalMap;

    EnumerableProposals.Bytes32ToProposalMap internal _proposals;

    function getProposals(uint256 offset, uint256 limit) public view returns (Proposal[] memory proposals) {
        bytes32[] memory keys = _proposals.getOrderedKeys(offset, limit);

        uint256 length = keys.length;
        proposals = new Proposal[](length);

        for (uint256 i = 0; i < length; ++i) {
            proposals[i] = _proposals.get(keys[i]);
        }
    }

    function getProposalAt(uint256 index) public view returns (Proposal memory) {
        return _proposals.at(index);
    }

    function getProposal(bytes32 key) public view returns (Proposal memory) {
        return _proposals.get(key);
    }

    function getProposalsLength() public view returns (uint256) {
        return _proposals.length();
    }

    function getOrderedKeys(uint256 offset, uint256 limit) public view returns (bytes32[] memory) {
        return _proposals.getOrderedKeys(offset, limit);
    }

    function _pushProposal(bytes32 key, uint256 proposalType, bytes memory data) internal {
        _proposals.push(key, proposalType, data);
    }
}
