module nft::nft{
    use std::string::{Self, String};
    use sui::object::{Self};
    use sui::event;

    public struct MyNFT has key, store {
        id: UID,
        name: String,
        description: String,
        image_url: String,
    }

    public struct MintEvent has copy, drop {
        object_id: address,
        recepient: address,
    }

    public fun mint(name: vector<u8>, description: vector<u8>, image_url: vector<u8>, ctx: &mut TxContext){
        // validations
        // created the nft
        let nft = MyNFT {
            id: object::new(ctx),
            name: string::utf8(name),
            description: string::utf8(description),
            image_url: string::utf8(image_url)
        };

        // got the owner/ sender of the transaction
        let recepient = tx_context::sender(ctx);

        // emit the event that a nft has been created
        event::emit(MintEvent{
            object_id: object::uid_to_address(&nft.id),
            recepient,
        });

        //transfer the ownership of the nft to the owner
        transfer::transfer(nft, recepient);

    }

    public fun get_name(nft: &MyNFT): String{
        (nft.name)
    }

    //get details of the mint
    //burn the nft
}



