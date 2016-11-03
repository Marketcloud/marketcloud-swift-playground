import UIKit

//Init marketcloud object with your public key
//feel free to use this key for testing purposes :)
let marketcloud = Marketcloud(key: "2cd15ec1-833c-4713-afbf-b7510e357bc8")

//---------------------PRODUCTS------------------------------
func testProducts() {
    //Fetches all your products
    print(marketcloud.getProducts())
    //Fetches one product by its id
    print(marketcloud.getProductById(17389))
    print(marketcloud.getProductById("17389"))
    //Tries to fetch a non-existent product
    print(marketcloud.getProductById(999999))
    //Fetches products by a category id
    print(marketcloud.getProductsByCategory(17390))
    print(marketcloud.getProductsByCategory("17390"))
    print(marketcloud.getProductsByCategory(9999999))
}

//---------------------CATEGORIES------------------------------
func testCategories() {
    //Fetches all the categories on your store
    print(marketcloud.getCategories())
    //Fetches a single category by its id
    print(marketcloud.getCategoryById(17390))
    print(marketcloud.getCategoryById("17390"))
    //Tries to fetch a non-existent category
    print(marketcloud.getCategoryById(9999999))
}

//---------------------BRANDS----------------------------------
//Same of categories, but with brands
func testBrands() {
    print(marketcloud.getBrands())
    
    print(marketcloud.getBrandById(17391))
    print(marketcloud.getBrandById("17391"))
    
    print(marketcloud.getBrandById(999999))
}

//---------------------CARTS-----------------------------------
func testCarts() {
    //Creates and empty cart
    print(marketcloud.createEmptyCart())
    //Fetches a cart by its ID
    print(marketcloud.getCart(17392))
    //Tries to fetch a non-existent cart
    print(marketcloud.getCart(999999))
}

func getLoggedUserCart() {
    //!!! THIS WILL ONLY WORK IF USER IS LOGGED IN
    print(marketcloud.getCart())
}

//Add a products to a cart
func testAddToCart(idCart:Int) {
    var itemArray = [Any]()
    itemArray.append(["product_id":17389,"quantity":1])
    
    print(marketcloud.addToCart(idCart, data: itemArray))
}

//Update the quantity of a product in a cart
func testUpdateCart(idCart:Int) {
    var itemArray = [Any]()
    //if the product is not in the cart it will be added
    itemArray.append(["product_id":17389,"quantity":6])
    
    print(marketcloud.updateCart(idCart, data: itemArray))
}

//Removes a product from a cart
func testRemoveFromCart(idCart:Int) {
    var itemArray = [Any]()
    //Product must be in the cart, otherwise nothing will happen
    itemArray.append(["product_id":17389])
    
    print(marketcloud.removeFromCart(idCart, data: itemArray))
}
//---------------------ADDRESSES-----------------------------
//Create an Address, then tries to fetch it by its id
func testAddresses() {
    let testAddress:[String:String] = ["email":"fakemail9@lmao.it","full_name": "alienFromOuterSpace","country" : "universe", "state": "thatStateOverThere", "city": "ayDeLaLmao", "address1": "ayyy, 123123", "postal_code": "420", "address 2":"ayyy2"]
    marketcloud.createAddress(testAddress)
    print(marketcloud.getAddresses())

    print(marketcloud.getAddress(93917)) //Insert a valid address ID
    //print(marketcloud.getAddress("17397")) //Insert a valid address ID

    //Tries to update the last inserted address by its id, then  tries to remove it
    let testModifiedAddress:[String:String] = ["email":"thisEmailHasBeenModified@lmao.it","full_name": "modifiedAlienFromOuterSpace","country" : "modifiedUniverse", "state": "modifiedThatStateInThatPlace", "city": "modifiedAyDeLaLmao", "address1": "modifiedAyyy, 1", "postal_code": "m421", "address2": "modifiedAyyy, 2"]
    print(marketcloud.updateAddress(93917, datas: testModifiedAddress)) //insert a valid address id here
    
    //remove next comment to delete an address
    //print(marketcloud.removeAddress(93917)) //insert a valid address id here
}
//-------------------------USERS-------------------------------
//Creates a user
func testCreateUser() {
    let testUserData:[String:String] = ["email":"swift3@lmao.it","name": "swiftAlienFromOuterSpace","password" : "universe"]
    print(marketcloud.createUser(testUserData));
}

//Example of user logIn
func logIn() {
    let loginTest:[String:String] = ["email":"swift3@lmao.it", "password":"universe"]
    marketcloud.logIn(loginTest)
    /* if the login operation succeed, headers will be changed and a user-token will be added to them.
        This means that some operations (ex.marketcloud.getCart()) will automatically retireve user-related informations reading the token.*/
    
    /* User can also logOut. The token will be removed from the headers and all the methods will work as an unlogged user */
    //marketcloud.logOut()
}
//--------------------------ORDERS-----------------------------
//Creates an order
func testOrderCreate(shippingAddressId:Int, billingAddressId:Int, cart_id:Int) {
    print(marketcloud.createOrder(shippingAddressId, billingId: billingAddressId, cartId: cart_id))
}

//--------------------------Other-----------------------------
func testConnectivity() {
    print(Reachability.isConnectedToNetwork())
    print(Reachability.checkConnectionType())
}
//-------------------------------------------------------------
/*Marketcloud's Official Swift 3 Playground*/

/*
 write here your code
 you can use the test methods (eg. testCarts() or writing your own code).
 
 This is an example of working flow with the following operations:
 An user register itself to the store
 Then he logs in
 A cart is created. The user adds a product to the cart, then modify its quantity and
 eventually he creates and address and concludes the order.
*/

//Change the email if already taken!!!
let email:String = "thisIsANewUser123@email.it"
let newUser = marketcloud.createUser(["email": email,"name": "reallyNewUser","password" : "newUser"]);

print("User created")
//print(newUser)

marketcloud.logIn(["email":email,"password" : "newUser"])

marketcloud.createEmptyCart()
var cart = marketcloud.getCart()
//print(cart)


let cartId:Int = (cart.value(forKey: "data") as! NSDictionary).value(forKey: "id") as! Int
print("cart id is \(cartId)")


var productsList = [Any]()
productsList.append(["product_id":17389,"quantity":1])

cart = marketcloud.addToCart(cartId, data: productsList)
//print(cart)


var updateProductsList = [Any]()
productsList.append(["product_id":17389,"quantity":3])

cart = marketcloud.updateCart(cartId, data: productsList)
//The cart has been updated. quantity of obj 17389 will now be 3!
//print(cart)

let newAddress:[String:String] = ["email": email,"full_name": "newUser","country" : "universe", "state": "thatStateOverThere", "city": "ayDeLaLmao", "address1": "ayyy, 123123", "postal_code": "420", "address 2":"ayyy2"]
let address:NSDictionary = marketcloud.createAddress(newAddress)
print("a new address has been created!")
//print(address)

let addressId:Int = (address.value(forKey: "data") as! NSDictionary).value(forKey: "id") as! Int
print("address id is \(addressId)")

//the order is ready to be created!
let theOrder = marketcloud.createOrder(addressId, billingId: addressId, cartId: cartId)
//print(theOrder)

let orderId:Int = (theOrder.value(forKey: "data") as! NSDictionary).value(forKey: "id") as! Int
print("order id is \(orderId)")

