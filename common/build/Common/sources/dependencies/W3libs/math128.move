// Copyright (c) Web3 Labs, Inc.
// SPDX-License-Identifier: GPL-3.0

module w3libs::math128 {

    /// Return the largest of two numbers.
    public fun max(a: u128, b: u128): u128 {
        if (a >= b) a else b
    }

    /// Return the smallest of two numbers.
    public fun min(a: u128, b: u128): u128 {
        if (a < b) a else b
    }

    /// Return the average of two.
    public fun average(a: u128, b: u128): u128 {
        if (a < b) {
            a + (b - a) / 2
        } else {
            b + (a - b) / 2
        }
    }

    /// Return the value of n raised to power e
    public fun pow(n: u128, e: u128): u128 {
        if (e == 0) {
            1
        } else {
            let p = 1;
            while (e > 1) {
                if (e % 2 == 1) {
                    p = p * n;
                };
                e = e / 2;
                n = n * n;
            };
            p * n
        }
    }
}
