
module voting_contract::dashboard;

public struct Dashboard has key {
    id: UID,
    proposal_ids: vector<ID>
}

/*
init function only run once when the contract is deployed
*/

fun init(ctx: &mut TxContext) {
   init_dashboard(ctx);
}

public fun init_dashboard(ctx: &mut TxContext){
    let dashboard = Dashboard{
        id: object::new(ctx),
        proposal_ids: vector[]
    };

    transfer::share_object(dashboard);
}

/*
when we pass self the function knows that it needs to modify itself
now we can use the function like this:
dashboard.register_proposal(proposal_id);

here the function is receiving the dashbaord struct as a reference and its gonna add the proposal id to the proposals vector


if we didnt use self, then we need to call the register_proposal function like this:
register_proposal(&mut dashboard, proposal_id);

*/
public fun register_proposal(self: &mut Dashboard, proposal_id: ID){
    // add proposal id to the dashboard proposals vector
    self.proposal_ids.push_back(proposal_id);
}


#[test]
fun test_module_init() {
    use sui::test_scenario;

    let creator = @0x1;

    let mut scenario = test_scenario::begin(creator);
    {
        // create the dashboard
        init(scenario.ctx());
    };

    scenario.next_tx(creator);
    {
        // retrieve the dashboard. take_shared() is used to retrieve the shared object from the scenario. 
        let dashboard = scenario.take_shared<Dashboard>();

        // check for the proposal ids
        assert!(dashboard.proposal_ids.is_empty(), 1);

        // returning the dashboard to the scenario
        test_scenario::return_shared(dashboard);
    };

    scenario.end();
}