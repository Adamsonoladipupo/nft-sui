#[test_only]
module nft::nft_tests{
    use sui::test_scenario;
    use nft::nft::{Self, MyNFT, get_name};

    #[test]
    fun test_that_an_nft_can_be_minted(){
        let owner = @0xA;
        let mut scenario = test_scenario::begin(owner);

        // mint the nft
        test_scenario::next_tx(&mut scenario, owner);
        {
            nft::mint(b"Semicolon", b"Testing", b"www.semicolon.africa", test_scenario::ctx(&mut scenario))
        };
        // check that nft exists and belongs to the owner

        test_scenario::next_tx(&mut scenario, owner);
        {
            let nft = test_scenario::take_from_sender<MyNFT>(&scenario);
            assert!(nft::get_name(&nft)== std::string::utf8(b"Semicolon"), 0);
            test_scenario::return_to_sender(&scenario, nft)
        };

        test_scenario::end(scenario);
    }
}
