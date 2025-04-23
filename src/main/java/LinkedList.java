public class LinkedList {
    private class Node {
        String ingredientName;
        int quantity;
        Node next;

        Node(String stringValue, int intValue) {
            this.ingredientName = stringValue;
            this.quantity = intValue;
        }
    }

    private Node head;

    public void add(String ingredientName, int quantity) {
        Node newNode = new Node(ingredientName, quantity);
        if (head == null) {
            head = newNode;
        } else {
            Node current = head;
            while (current.next != null) {
                current = current.next;
            }
            current.next = newNode;
        }
    }

    public Node getHead() {
        return head;
    }
}