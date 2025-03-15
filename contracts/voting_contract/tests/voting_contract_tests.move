
#[test_only]
module voting_contract::voting_contract_tests;

#[test]
fun test_create_proposal() {
    use sui::test_scenario;
    use voting_contract::proposal::{Self, Proposal};

    let user = @0x2;

    let mut scenario = test_scenario::begin(user);
    {

        let sender = scenario.ctx().sender();
    
    };

    scenario.next_tx(user);
    {

        let title  = b"test title".to_string();
        let description = b"test description".to_string();
        let expiration = 1000000000;
        proposal::create(title, description, expiration, scenario.ctx());

    };

    scenario.next_tx(user);
    {
        let title  = b"test title".to_string();
        let description = b"test description".to_string();
        let expiration = 1000000000;

        let created_proposal = scenario.take_shared<Proposal>();
        let proposal_title = created_proposal.get_title();

        assert!(proposal_title == title);

        let proposal_description = created_proposal.get_description();
        assert!(proposal_description == description, 2);

        let proposal_expiration = created_proposal.get_expiration();
        assert!(proposal_expiration == expiration, 3);

        let proposal_creator = created_proposal.get_creator();
        assert!(proposal_creator == @0x2, 4);

        let proposal_yes_votes = created_proposal.get_yes_votes();
        assert!(proposal_yes_votes == 0, 5);

        let proposal_no_votes = created_proposal.get_no_votes();
        assert!(proposal_no_votes == 0, 6);
        
        let proposal_voter_registry = created_proposal.get_voter_registry();
        assert!(proposal_voter_registry.is_empty(), 7);
        
        
        test_scenario::return_shared(created_proposal);
    };

    scenario.end();
    
}