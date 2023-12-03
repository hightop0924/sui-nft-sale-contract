module consoledrop::consoledrop_entries {

    use consoledrop::consoledrop::{NftAdminCap, NftPool, NftTreasuryCap};
    use consoledrop::consoledrop;
    use sui::tx_context::TxContext;
    use sui::clock::Clock;
    use sui::coin::Coin;
    use common::kyc::Kyc;

    public entry fun create_pool<COIN>(_adminCap: &NftAdminCap,
                                       owner: address,
                                       soft_cap_percent: u64,
                                       round: u8,
                                       use_whitelist: bool,
                                       vesting_time_seconds: u64,
                                       publicSalePrice: u64,
                                       start_time: u64,
                                       end_time: u64,
                                       presale_start_time: u64,
                                       presale_end_time: u64,
                                       system_clock: &Clock,
                                       require_kyc: bool,
                                       ctx: &mut TxContext) {
        consoledrop::create_pool<COIN>(_adminCap,
            owner,
            soft_cap_percent,
            round,
            use_whitelist,
            vesting_time_seconds,
            publicSalePrice,
            start_time,
            end_time,
            presale_start_time,
            presale_end_time,
            system_clock,
            require_kyc,
            ctx);
    }

    public entry fun add_collection<COIN>(_adminCap: &NftAdminCap,
                                          pool: &mut NftPool<COIN>,
                                          cap: u64, //max of NFT to sale
                                          allocate: u64, //max allocate per user
                                          price: u64, //price with coin
                                          type: u8, //collection type
                                          name: vector<u8>,
                                          baseURI: vector<u8>,
                                          contractURI: vector<u8>,
                                          description: vector<u8>,
                                          project_url: vector<u8>,
                                          edition: u64,
                                          thumbnail_url: vector<u8>,
                                          creator: vector<u8>,
                                          _ctx: &mut TxContext
    ) {
        consoledrop::add_collection<COIN>(_adminCap, pool, cap, allocate, price, type,
            name, baseURI, contractURI, creator, _ctx);
    }

    public entry fun start_pool<COIN>(adminCap: &NftAdminCap, pool: &mut NftPool<COIN>, system_clock: &Clock) {
        consoledrop::start_pool<COIN>(adminCap, pool, system_clock);
    }

    public entry fun adminMint<COIN>(
                                    _adminCap: &NftAdminCap,
                                    to: address,
                                    nft_types: vector<u8>,
                                    nft_amounts: vector<u64>,
                                    pool: &mut NftPool<COIN>,
                                    system_clock: &Clock,
                                    kyc: &Kyc,
                                    ctx: &mut TxContext
    ) {
        consoledrop::adminMint<COIN>(_adminCap, to, nft_types, nft_amounts, pool, system_clock, kyc, ctx);
    }

    public entry fun airdropAdminMint<COIN>(
                                    _adminCap: &NftAdminCap,
                                    to: vector<address>,
                                    nft_types: vector<u8>,
                                    nft_amounts: vector<u64>,
                                    pool: &mut NftPool<COIN>,
                                    system_clock: &Clock,
                                    kyc: &Kyc,
                                    ctx: &mut TxContext
    ) {
        consoledrop::airdropAdminMint<COIN>(_adminCap, to, nft_types, nft_amounts, pool, system_clock, kyc, ctx);
    }

    public entry fun buy_nft<COIN>(coin_in: &mut Coin<COIN>,
                                   nft_types: vector<u8>,
                                   nft_amounts: vector<u64>,
                                   pool: &mut NftPool<COIN>,
                                   system_clock: &Clock,
                                   kyc: &Kyc,
                                   ctx: &mut TxContext) {
        consoledrop::buy_nft<COIN>(coin_in, nft_types, nft_amounts, pool, system_clock, kyc, ctx);
    }

    public entry fun stop_pool<COIN>(_adminCap: &NftAdminCap, pool: &mut NftPool<COIN>, system_clock: &Clock) {
        consoledrop::start_pool<COIN>(_adminCap, pool, system_clock);
    }

    public entry fun claim_nft<COIN>(pool: &mut NftPool<COIN>, system_clock: &Clock, ctx: &mut TxContext) {
        consoledrop::claim_nft<COIN>(pool, system_clock, ctx);
    }

    public entry fun claim_refund<COIN>(pool: &mut NftPool<COIN>, system_clock: &Clock, ctx: &mut TxContext) {
        consoledrop::claim_refund<COIN>(pool, system_clock, ctx);
    }

    public entry fun add_whitelist<COIN>(_adminCap: &NftAdminCap, pool: &mut NftPool<COIN>, tos: vector<address>) {
        consoledrop::add_whitelist(_adminCap, pool, tos);
    }

    public entry fun remove_whitelist<COIN>(_adminCap: &NftAdminCap, pool: &mut NftPool<COIN>, froms: vector<address>) {
        consoledrop::remove_whitelist(_adminCap, pool, froms);
    }

    public entry fun withdraw_fund<COIN>(
        _adminCap: &NftTreasuryCap,
        pool: &mut NftPool<COIN>,
        amt: u64,
        ctx: &mut TxContext
    ) {
        consoledrop::withdraw_fund(_adminCap, pool, amt, ctx);
    }

    public entry fun transferOwnership(adminCap: NftAdminCap, to: address) {
        consoledrop::transferOwnership(adminCap, to);
    }

    public entry fun remove_collection<COIN>(_admin_cap: &NftAdminCap, type: u8, pool: &mut NftPool<COIN>) {
        consoledrop::remove_collection(_admin_cap, type, pool);
    }

    public entry fun change_treasury_admin(adminCap: NftTreasuryCap, to: address) {
        consoledrop::change_treasury_admin(adminCap, to);
    }
}