%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin

from erc4906.library import ERC4906

@external
func test_initialization{syscall_ptr: felt*, range_check_ptr, pedersen_ptr: HashBuiltin*}() {
    ERC4906.initializer();
    return ();
}
