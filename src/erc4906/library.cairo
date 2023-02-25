// SPDX-License-Identifier: MIT

%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import Uint256, uint256_check

from openzeppelin.introspection.erc165.library import ERC165
from openzeppelin.token.erc721.library import ERC721

from erc4906.utils.constants.library import IERC4906_ID

@event
func MetadataUpdate(tokenId: Uint256) {
}

@event
func BatchMetadataUpdate(fromTokenId: Uint256, toTokenId: Uint256) {
}

// / @title ERC4906 implementation.
// / @notice This file contains functions related to the ERC4906 implementation.
// / @author @bal7hazar
// / @custom:namespace ERC4906
namespace ERC4906 {
    // @notice Initialize the ERC4906 implementation.
    func initializer{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
        ERC165.register_interface(IERC4906_ID);
        return ();
    }

    // @notice Emit a MetadataUpdate event.
    // @dev It fails token_id is not a valid Uint256.
    // @param token_id The token id for which the event should be emitted.
    func metadata_update{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
        token_id: Uint256
    ) {
        // [Check] Uint256 compliance
        with_attr error_message("ERC4906: token_id is not a valid Uint256") {
            uint256_check(token_id);
        }

        // [Effect] Emit event
        MetadataUpdate.emit(tokenId=token_id);
        return ();
    }

    // @notice Emit a BatchMetadataUpdate event.
    // @dev It fails from_token_id or to_token_id are not a valid Uint256.
    // @param from_token_id The token id from which to start the batch.
    // @param to_token_id The token id from which to end the batch.
    func batch_metadata_update{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
        from_token_id: Uint256, to_token_id: Uint256
    ) {
        // [Check] Uint256 compliance
        with_attr error_message("ERC4906: from_token_id is not a valid Uint256") {
            uint256_check(from_token_id);
        }
        with_attr error_message("ERC4906: to_token_id is not a valid Uint256") {
            uint256_check(to_token_id);
        }

        // [Effect] Emit event
        BatchMetadataUpdate.emit(fromTokenId=from_token_id, toTokenId=to_token_id);
        return ();
    }

    // @notice Set token uri.
    // @param token_id The token id for which the uri must be updated.
    // @param token_uri The new token uri.
    func _set_token_uri{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
        token_id: Uint256, token_uri: felt
    ) {
        ERC721._set_token_uri(token_id, token_uri);
        metadata_update(token_id);
        return ();
    }
}
