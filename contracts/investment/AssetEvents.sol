pragma solidity ^0.4.18;

/**
 * @title Asset Events 
 * @dev Defines events fired by fundraising assets
 */
contract AssetEvents {

    /**
     * Events   
     */
    event Invested(address _owner, address _investor, uint256 _value);
    event Canceled(address _owner, address _investor, uint256 _value);
    event Withdrawal(address _owner, address _investor, uint256 _value);
    event Refused(address _owner, address _investor, uint256 _value);
    event Returned(address _owner, address _investor, uint256 _value, bool _delayed);
    event Supplied(address _owner, uint256 _amount, uint256 _assetFuel);
    event TokenWithdrawal(address _to, uint256 _amount);
    event ForSale(address _investor, uint256 _value);
    event CanceledSell(address _investor, uint256 _value);
    
}    
