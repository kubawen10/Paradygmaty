class BBDecoratedScene implements SceneInterface{
    SceneInterface decoratedScene;

    BBDecoratedScene(SceneInterface decoratedScene){
        this.decoratedScene = decoratedScene;
    }

    void addItem(Item item){
        decoratedScene.addItem(item);
    }

    void display(){
        decoratedScene.display();

        drawBB();
    }

    ArrayList<Item> getItems(){
        return decoratedScene.getItems();
    }

    private void drawBB(){
        ArrayList<Item> items = decoratedScene.getItems();
        Point mousePos = new Point (mouseX, mouseY);

        for(int i = 0; i < items.size(); i++){
            BoundingBox bb = items.get(i).getBoundingBox();
            if(bb.contains(mousePos)){
                bb.display();
            }
        }
    }
}