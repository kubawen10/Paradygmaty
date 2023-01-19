public class B extends A{
    B(){
        k++;
    }

    public static void main(String[] args) {
        System.out.println("Przed: " + k);
        B w = new B();
        System.out.println("Po " + k);
        w.mA();
    }
}
