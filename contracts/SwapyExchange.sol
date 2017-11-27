pragma solidity ^0.4.15;

import './investment/InvestmentAsset.sol';

contract SwapyExchange is AssetEvents {

  // Protocol version
  string constant public VERSION = "1.0.0";
  address public assetLibrary;

  event Offers(
    address _from,
    string _protocolVersion,
    address[] _assets
  );

  event Investments(
    address _investor,
    address _asset,
    address _owner,
    uint256 _value
  );

  function SwapyExchange(address _assetLibrary) {
    assetLibrary = _assetLibrary;
  }

  // Creates a new investment offer
  function createOffer(
      uint256 _paybackDays,
      uint256 _grossReturn,
      string _currency,
      bytes _offerTermsHash,
      uint256[] _assets)
    public
    returns(bool)
  {
    address[] memory newAssets = createOfferAssets(_assets, _currency, _offerTermsHash, _paybackDays, _grossReturn);
    Offers(msg.sender, VERSION, newAssets);
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
      newAssets[index] = new InvestmentAsset(assetLibrary, msg.sender, VERSION, _currency, _assets[index], _offerTermsHash, _paybackDays, _grossReturn);
    }
    return newAssets;
  }
  
  function invest(address _asset, bytes _agreementTermsHash) payable
    returns(bool)
  {
    InvestmentAsset asset = InvestmentAsset(_asset);
    require(_asset.call.value(msg.value)(bytes4(sha3("invest(address,bytes)")), msg.sender, _agreementTermsHash));
    Investments(msg.sender, _asset, asset.owner(), msg.value);  
    return true;
  }

}
