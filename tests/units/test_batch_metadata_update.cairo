%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import Uint256

from erc4906.library import ERC4906

@external
func test_metadata_update{syscall_ptr: felt*, range_check_ptr, pedersen_ptr: HashBuiltin*}() {
    let from_token_id = Uint256(low=1, high=0);
    let to_token_id = Uint256(low=10, high=0);

    %{ expect_events({"name": "BatchMetadataUpdate", "data": [1, 0, 10, 0]}) %}
    ERC4906.batch_metadata_update(from_token_id, to_token_id);

    return ();
}
