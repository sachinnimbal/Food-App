package com.foodiedelight.model;

import java.util.HashMap;
import java.util.Map;

public class CartGenerator {

	public Map<Integer, Cart> cart;

	public CartGenerator() {
		cart = new HashMap<Integer, Cart>();
	}

	public void addCartItem(Cart c) {
		if (cart.containsKey(c.getItemId())) {
			Cart existingCart = cart.get(c.getItemId());
			existingCart.setQuantity(existingCart.getQuantity() + c.getQuantity());
		} else {
			cart.put(c.getItemId(), c);
		}
	}

	public void UpdateCartItem(int itemId, int Quantity) {
		// cart.get(itemId).setQuantity(Quantity);
		if (cart.containsKey(itemId)) {
			Cart existingCart = cart.get(itemId);
			existingCart.setQuantity(Quantity);
		} else {
			System.out.println("Item with ID " + itemId + " not found in the cart.");
		}
	}

	public void removeCartItem(int itemId) {
		cart.remove(itemId);
	}

	public void clearCart() {
		this.cart.clear();
	}
}
