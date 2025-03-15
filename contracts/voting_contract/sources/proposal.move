module voting_contract::proposal;

use std::string::String;

public struct Proposal has key {
    id: UID,
    title: String,
    description: String,
    yes_votes: u64,
    no_votes: u64,
    expiration: u64,
    creator: address,
    voter_registry: vector<address>,
    
}

/*

In Sui Move, the TxContext parameter tracks all side effects that occur during a transaction (e.g., creating new objects, emitting events). 
Any function that mutates the transaction’s state must take the context by a mutable reference (&mut).

When you call object::new(ctx), you’re registering a newly created on-chain object in the transaction context. 
That action changes the state recorded in TxContext. Therefore, the function needs &mut TxContext so the runtime (and the compiler) knows that 
you’re making changes that must be tracked in the transaction’s side effects. 
If the function only read data from the context without modifying it, you could take &TxContext (an immutable reference) instead.

*/

public fun create(title: String, description: String, expiration: u64, ctx: &mut TxContext) {

    let proposal = Proposal {
        id: object::new(ctx),
        title,
        description,
        yes_votes: 0,
        no_votes: 0,
        creator: ctx.sender(),
        expiration,
        voter_registry: vector[],
    };

/*
In Move, every value of a type without the drop ability must be “consumed” by the end of the function—that is, either transferred, stored, or returned. 
You can’t just let it fall out of scope. When you see an error like:

The local variable 'proposal' still contains a value. The value does not have the 'drop' ability and must be consumed before the function returns

it means that at the end of your function, there’s still a resource (the proposal) sitting in a local variable that was never properly “used up.”


*/
    transfer::share_object(proposal);
}



