public class Main{
    public static void main(String[] args){
        int j[] = {4,7,2,9,5} ;
        int z =0;
        for(int i:j ){
            if(z<i) {
                z = i;
            }
            System.out.println(z);
        }
    }
}