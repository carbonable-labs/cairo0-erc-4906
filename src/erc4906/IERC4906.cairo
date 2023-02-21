// SPDX-License-Identifier: MIT

%lang starknet

from starkware.cairo.common.uint256 import Uint256

@contract_interface
namespace IERC4906 {
    func setTokenURI(tokenId: Uint256, tokenURI: felt) {
    }

    func emitBatchMetadataUpdate(fromTokenId: Uint256, toTokenId: Uint256) {
    }
}
