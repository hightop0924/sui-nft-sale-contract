module consoledrop::nft_primary {
    friend consoledrop::consoledrop;

    use sui::url::{Self, Url};
    use std::string;
    use sui::object::{Self, ID, UID};
    use sui::tx_context::{TxContext};
    use std::vector;
    use sui::table::Table;
    use sui::vec_map::VecMap;
    use sui::table;
    use sui::vec_map;

    /// Allow custome attributes
    struct PriNFT has key, store {
        id: UID,
        name: string::String, 
        baseURI: string::String, 
        contractURI: string::String, 
        creator: string::String, 
    }

    struct MintNFTEvent has copy, drop {
        object_id: ID,
        creator: address,
        name: string::String,
        project_url: Url,
    }

    /// Create a new NFT
    public(friend) fun mint(
        name: vector<u8>,
        baseURI: vector<u8>,
        contractURI: vector<u8>,
        creator: vector<u8>,
        ctx: &mut TxContext
    ): PriNFT {
        PriNFT {
            id: object::new(ctx),
            name: string::utf8(name),
            baseURI: string::utf8(baseURI),
            contractURI: string::utf8(contractURI),
            creator: string::utf8(creator),
        }
    }


    #[test_only]
    public fun mint_for_test(
        name: vector<u8>,
        baseURI: vector<u8>,
        contractURI: vector<u8>,
        creator: vector<u8>,
        ctx: &mut TxContext): PriNFT{
        mint(name, baseURI, contractURI, creator, ctx)
    }

    public(friend) fun mint_batch(
        count: u64,
        name: vector<u8>,
        baseURI: vector<u8>,
        contractURI: vector<u8>,
        creator: vector<u8>,
        ctx: &mut TxContext
    ): vector<PriNFT> {
        assert!(count > 0, 1);
        let nfts  = vector::empty<PriNFT>();

        while (count > 0){
            vector::push_back(
                &mut nfts,
                mint(name, baseURI, contractURI, creator, ctx));
            count = count -1;
        };

        nfts
    }


    /// Permanently delete `nft`
    public(friend) fun burn(nft: PriNFT) {
        let PriNFT { id,
            name: _name,
            baseURI: _baseURI,
            contractURI: _contractURI,
            creator: _creator,
        } = nft;
        object::delete(id);
    }


    #[test_only]
    public fun burn_for_test(nft: PriNFT) {
       burn(nft);
    }

    public fun name(nft: &PriNFT): &string::String {
        &nft.name
    }

    public(friend) fun update_baseURI(
        nft: &mut PriNFT,
        baseURI : vector<u8>,
    ) {
        nft.baseURI = string::utf8(baseURI)
    }

    public(friend) fun update_contractURI(
        nft: &mut PriNFT,
        contractURI : vector<u8>,
    ) {
        nft.contractURI = string::utf8(contractURI)
    }

    public fun contractURI(nft: &PriNFT): &string::String {
        &nft.contractURI
    }
    
    public fun baseURI(nft: &PriNFT): &string::String {
        &nft.baseURI
    }

    public fun creator(nft: &PriNFT): &string::String {
        &nft.creator
    }


    fun vec2map<K: copy + drop + store, V: store + copy>(vdata: &VecMap<K, V>, ctx: &mut TxContext): Table<K, V>{
        let keys = vec_map::keys(vdata);
        let ksize = vector::length<K>(&keys);
        let tab = table::new<K,V>(ctx);
        while (ksize > 0){
            ksize = ksize -1;
            let key = vector::pop_back(&mut keys);
            table::add(&mut tab, key, *vec_map::get(vdata, &key))
        };

        tab
    }
}

#[test_only]
module consoledrop::private_nftTests {
    use consoledrop::nft_primary::{Self, PriNFT};
    use sui::test_scenario as ts;
    use sui::transfer;
    use std::string;
    use sui::vec_map;
    use std::ascii::String;
    use sui::table;
    use sui::test_scenario;

    #[test]
    fun mint_transfer_update() {
        let addr1 = @0xA;
        let addr2 = @0xB;
        // create the NFT
        let scenario = ts::begin(addr1);
            {
                let nft = nft_primary::mint_for_test(
                    b"name",
                    b"baseURI",
                    b"contractURI",
                    b"creator",
                    ts::ctx(&mut scenario));
                transfer::public_transfer(nft,  addr1);
            };
        // send it from A to B
        ts::next_tx(&mut scenario, addr1);
            {
                let nft = ts::take_from_sender<PriNFT>(&mut scenario);
                transfer::public_transfer(nft, addr2);
            };
        
        // burn it
        ts::next_tx(&mut scenario, addr2);
            {
                let nft = ts::take_from_sender<PriNFT>(&mut scenario);
                nft_primary::burn_for_test(nft)
            };
        ts::end(scenario);
    }
}