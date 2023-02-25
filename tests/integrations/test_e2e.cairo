// SPDX-License-Identifier: MIT

%lang starknet

// Starkware dependencies
from starkware.cairo.common.bool import TRUE, FALSE
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import Uint256

from openzeppelin.token.erc721.IERC721Metadata import IERC721Metadata

from erc4906.IERC4906 import IERC4906

const NAME = 'NAME';
const SYMBOL = 'SYMBOL';
const OWNER = 0x123;
const ANYONE = 0x456;

@contract_interface
namespace IERC721 {
    func mint(to: felt, tokenId: Uint256) {
    }
}

@view
func __setup__{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    %{
        context.contract_address = deploy_contract(
            contract="./src/erc4906/presets/ERC721MetadataUpdate.cairo",
            constructor_args={
                "name": ids.NAME,
                "symbol": ids.SYMBOL,
                "owner": ids.OWNER,
            }
        ).contract_address
    %}

    return ();
}

@view
func test_set_token_uri{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    let one = Uint256(low=1, high=0);
    let token_uri = 'uri';

    tempvar contract_address;
    %{ ids.contract_address = context.contract_address %}

    %{
        stop_prank = start_prank(caller_address=ids.OWNER, target_contract_address=context.contract_address)
        expect_events({"name": "MetadataUpdate", "data": [1, 0]})
    %}
    IERC721.mint(contract_address=contract_address, to=ANYONE, tokenId=one);
    IERC4906.setTokenURI(contract_address=contract_address, tokenId=one, tokenURI=token_uri);
    %{ stop_prank() %}

    let (returned_token_uri) = IERC721Metadata.tokenURI(
        contract_address=contract_address, tokenId=one
    );
    assert returned_token_uri = token_uri;

    return ();
}

@view
func test_emit_batch_metadata_revert_not_owner{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr
}() {
    let one = Uint256(low=1, high=0);
    let ten = Uint256(low=10, high=0);

    tempvar contract_address;
    %{ ids.contract_address = context.contract_address %}

    %{
        stop_prank = start_prank(caller_address=ids.ANYONE, target_contract_address=context.contract_address)
        expect_revert("TRANSACTION_FAILED", "Ownable: caller is not the owner")
    %}
    IERC4906.emitBatchMetadataUpdate(
        contract_address=contract_address, fromTokenId=one, toTokenId=ten
    );
    %{ stop_prank() %}

    return ();
}
