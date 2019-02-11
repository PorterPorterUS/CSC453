package cs453;

import java.util.ArrayList;

import cs453.HashNode;

public class HashTable<K, V> {
	private ArrayList<HashNode<K, V>> buckets;
	
	// Total capacity of buckets
	private int capacity;
	
	// Current size of buckets
	private int size;
	
	private int getBucketIndex(K key) {
		int hashcode = key.hashCode();
		
		return hashcode % this.capacity; 
	}
	
	public int size() {
		return this.size;
	}
	
	public int capacity() {
		return this.capacity;
	}
	
	// Constructor
	public HashTable(int capacity) {
		this.buckets = new ArrayList<HashNode<K, V>>();
		this.capacity = capacity;
		this.size = 0;
		
		for (int i = 0; i < this.capacity; i++){
			this.buckets.add(null);
		}	
	}
	
	// Get the value for a given key
	public V get(K key) {
		int bucketIndex = getBucketIndex(key);
		HashNode<K, V> headNode = this.buckets.get(bucketIndex);
		while (headNode != null) {
			if (headNode.key.equals(key)) {
				return headNode.value;
			}
			headNode = headNode.next;
		}
		
		// Not found the key
		return null;
	}
	
	// Remove a pair for a given key
	public V remove(K key) {
		int bucketIndex = getBucketIndex(key);
		HashNode<K, V> headNode = this.buckets.get(bucketIndex);
		HashNode<K, V> prevNode = null;
		
		while (headNode != null) {
			if (headNode.key.equals(key)) {
				break;
			}
			prevNode = headNode;
			headNode = headNode.next;
		}
		
		// Not found the key
		if (headNode == null) {
			return null;
		}
		
		if (prevNode == null) {
			this.buckets.set(bucketIndex, headNode.next);
		} else {
			prevNode.next = headNode.next;
		}
		
		this.size -= 1;
		
		return headNode.value;
	}
	
	public void add(K key, V value) {
		int bucketIndex = getBucketIndex(key);
		HashNode<K, V> headNode = this.buckets.get(bucketIndex);
		
		while (headNode != null) {
			if (headNode.key.equals(key)) {
				headNode.value = value;
				return;
			}
			headNode = headNode.next;
		}
		
		// Insert a new node at the first place of a chain
		headNode = this.buckets.get(bucketIndex);
		HashNode<K, V> newNode = new HashNode<K, V>(key, value);
		newNode.next = headNode;
		this.buckets.set(bucketIndex, newNode);
		this.size += 1;
		
		// Double hash table size
		if ((float)this.size / this.capacity >= 0.7) {
			this.size = 0;
			this.capacity *= 2;
			ArrayList<HashNode<K, V>> tmpBuckets = this.buckets;
			this.buckets = new ArrayList<>();
			
			for (int i = 0; i < this.capacity; i++) {
				this.buckets.add(null);
			}
			
			for (HashNode<K, V> node : tmpBuckets) {
				while (node != null) {
					add(node.key, node.value);
					node = node.next;
				}
			}
		}
	}
}
