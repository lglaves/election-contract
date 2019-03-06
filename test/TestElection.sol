pragma solidity >=0.4.21 <0.6.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Election.sol";

contract TestElection{
    Election instance = Election(DeployedAddresses.Election());
    
    function testNameIsExpected() public {
        //string result = instance.name();
        
        //Assert.equal(result, "Presidential Election 2020", "name should be as expected");
    }
    
    // tuple used to return multiple values of different types
    function testNonAuthorizedVoteDoesNotCount() public {
        uint preVoteCount;
        (, preVoteCount) = instance.candidates(0);
        
        instance.vote(0);
        
        var (,postVoteCount) = instance.candidates(0);
        
        Assert.equal(preVoteCount, postVoteCount, "prevotecount should be same as postvotecount");
    }
    
    function testNonOwnersCannotAuthorizeVoters() public {
        ThrowProxy proxy = new ThrowProxy(address(instance));
        
        Election(address(proxy)).authorize(this);
        
        bool result = proxy.execute();
        
        Assert.isFalse(result, "proxy should throw exception when calling authorize()");
    }
    
    function testAuthorizedVotesShouldBeCounted() public {
        Election instance = new Election("test name", "candidate 1", "candidate 2");
        
        var (,preVoteCount) = instance.candidates(0);
        
        // Proxy will be the contract that invokes the vote function on
        // the election contract, so it needs to be authorized
        instance.authorize(this);
        instance.vote(0);
        
        var (,postVoteCount) = instance.candidates(0);
        
        Assert.equal(preVoteCount+1, postVoteCount, "authorized vote should increase vote count");
    }
    
    function testAuthorizedVotersOnlyVoteOnce() public {
        Election instance = new Election("name", "can1", "can2");
        ThrowProxy proxy = new ThrowProxy(address(instance));
        
        instance.authorize(proxy);
        
        Election(address(proxy)).vote(0);
        bool firstVoteResult = proxy.execute();
        
        Election(address(proxy)).vote(0);
        bool secondVoteResult = proxy.execute();
        
        Assert.isTrue(firstVoteResult, "proxy should not throw exception when calling vote() once");
        Assert.isFalse(secondVoteResult, "proxy should throw exception when calling vote() twice");
    }
}

// Proxy contract for catching exceptions
contract ThrowProxy {
    address public target;
    bytes data;

    function ThrowProxy(address _target) public {
        target = _target;
    }

  //prime the data using the fallback function.
    function() public {
        data = msg.data;
    }

    // This needs to be fixed per my supply chain tests example for Ethereum Bootcamp
    function execute() public returns (bool) {
        return target.call(data);
    }
}