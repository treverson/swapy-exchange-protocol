pragma solidity ^0.4.14;

import './investment/InvestmentAsset.sol';

contract SwapyExchange {

  // Protocol version
  string constant public VERSION = "1.0.0";

  event Offers(
    string _id,
    address _from,
    string _protocolVersion,
    address[] _assets
  );


  // Creates a new investment offer
  function createOffer(
      string _id,
      uint256 _paybackDays,
      uint256 _grossReturn,
      string _currency,
      bytes _offerTermsHash,
      uint256[] _assets)
    public
    returns(bool)
  {
    address[] memory newAssets = createOfferAssets(_assets, _currency, _offerTermsHash, _paybackDays, _grossReturn);
    Offers(_id, msg.sender, VERSION, newAssets);
    return true;
  }

  function createOfferAssets(
      uint256[] _assets,
      string _currency,
      bytes _offerTermsHash,
      uint _paybackDays,
      uint _grossReturn)
    internal
    returns (address[])
  {
    address[] memory newAssets = new address[](_assets.length);
    for (uint index = 0; index < _assets.length; index++) {
      newAssets[index] = address(new InvestmentAsset(msg.sender, VERSION, _currency, _assets[index], _offerTermsHash, _paybackDays, _grossReturn));
    }
    return newAssets;
  }

}