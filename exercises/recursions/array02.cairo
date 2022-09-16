%lang starknet

# Getting pointer as function arguments let us modify the values at the memory address of the pointer
# ...or not! Cairo memory is immutable. Therefore you cannot just update a memory cell.

# TODO: Update the square function – you can change the body and the signature –
# to make it achieve the desired result: returning an array
# with the squared values of the input array.

from starkware.cairo.common.alloc import alloc

func square(array : felt*, array_len : felt, newarray : felt*):
    if array_len == 0:
        return ()
    end

    let squared_item = [array] * [array]
    assert [newarray] = squared_item

    return square(array + 1, array_len - 1, newarray + 1)
end

# You can update the test if the function signature changes.
@external
func test_square{syscall_ptr : felt*}():
    alloc_locals
    let (local array : felt*) = alloc()
    let (local newarray : felt*) = alloc()

    assert [array] = 1
    assert [array + 1] = 2
    assert [array + 2] = 3
    assert [array + 3] = 4

    assert [newarray] = 1
    assert [newarray + 1] = 4
    assert [newarray + 2] = 9
    assert [newarray + 3] = 16

    square(array, 4, newarray)

    assert [newarray] = 1
    assert [newarray + 1] = 4
    assert [newarray + 2] = 9
    assert [newarray + 3] = 16

    return ()
end