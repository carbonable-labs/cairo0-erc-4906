%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import Uint256

from src.erc4906.library import ERC4906

@external
func test_metadata_update{syscall_ptr: felt*, range_check_ptr, pedersen_ptr: HashBuiltin*}() {
    let token_id = Uint256(low=1, high=0);

    %{ expect_events({"name": "MetadataUpdate", "data": [1, 0]}) %}
    ERC4906.metadata_update(token_id);

    return ();
}
