module w3libs::math128_test {
    #[test_only]
    use w3libs::math128::{max, min, average, pow};

    #[test]
    public entry fun test_max() {
        let result = max(3u128, 6u128);
        assert!(result == 6, 0);

        let result = max(15u128, 12u128);
        assert!(result == 15, 1);
    }

    #[test]
    public entry fun test_min() {
        let result = min(3u128, 6u128);
        assert!(result == 3, 0);

        let result = min(15u128, 12u128);
        assert!(result == 12, 1);
    }

    #[test]
    public entry fun test_average() {
        let result = average(3u128, 6u128);
        assert!(result == 4, 0);

        let result = average(15u128, 12u128);
        assert!(result == 13, 0);
    }

    #[test]
    public entry fun test_pow() {
        let result = pow(10u128, 18u128);
        assert!(result == 1000000000000000000, 0);

        let result = pow(10u128, 1u128);
        assert!(result == 10, 0);

        let result = pow(10u128, 0u128);
        assert!(result == 1, 0);
    }
}
