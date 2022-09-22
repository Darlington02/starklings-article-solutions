%lang starknet
%builtins bitwise

from starkware.cairo.common.bitwise import bitwise_and
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin

# Collatz sequence are defined as follow :
# If the number is even, divide it by two.
# If the number is odd, triple it and add one.
# If the number is one, stop the computation
# https://en.wikipedia.org/wiki/Collatz_conjecture

# TODO: write a recursive implementation of Collatz sequence that returns the nth collatz number from the seed
# HELP: number % 2 == 0 => bitwise_and(number, 1) == 0

func collatz{bitwise_ptr : BitwiseBuiltin*}(seed : felt, step : felt) -> (result : felt):
    if step == 0:
        return (seed)
    end

    if seed == 1:
        return (1)
    end

    let (evenStatus) = bitwise_and(seed, 1)

    if evenStatus == 0:
        let evenSeed = seed / 2
        let number: felt = collatz(evenSeed, step - 1)
    else:
        let oddSeed = seed * 3 + 1
        let number: felt = collatz(oddSeed, step - 1)
    end
    return (result=number)
end

# Do not change the test
@external
func test_collatz{syscall_ptr : felt*, bitwise_ptr : BitwiseBuiltin*}():
    let (n) = collatz(seed=42, step=0)
    assert n = 42
    let (n) = collatz(seed=42, step=1)
    assert n = 21
    let (n) = collatz(seed=42, step=2)
    assert n = 64
    let (n) = collatz(seed=42, step=3)
    assert n = 32
    let (n) = collatz(seed=42, step=4)
    assert n = 16
    let (n) = collatz(seed=42, step=5)
    assert n = 8
    let (n) = collatz(seed=42, step=6)
    assert n = 4
    let (n) = collatz(seed=42, step=7)
    assert n = 2
    let (n) = collatz(seed=42, step=8)
    assert n = 1
    let (n) = collatz(seed=42, step=9)
    assert n = 1
    let (n) = collatz(seed=42, step=42)
    assert n = 1
    return ()
end
