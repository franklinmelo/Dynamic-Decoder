# Dynamic-Decoder
An example of a dynamic type-based decoding strategy

## Summary
This is a stategy on how to decode a json with generic data.
In this example we need to decode a Vehicle model from a json API response, and the Vehicle has a `Type` and a `Data`, but the `Data` property can be changed depending on the `Type`.
So we need to get the `Type` of the Vehicle and from that `Type` return the corresponding Vehicle model.
 
## Install
- First Clone the repository
`git clone git@github.com:franklinmelo/Dynamic-Decoder.git`
- Open the file `SuperDecoder.playground` on your Xcode
- And Run 🎉
