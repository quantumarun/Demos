This Sample shows how to create a expandable and collapsible cell in UITableView

Lets walk through the example.
I have UITableView with custom UITableViewCell called customCell with identifier as Cell and Style as custom. Cell is design in Storyboard within the UITableView by adding UITableViewCell.

My customCell has 2 UIView - FirstView and SecondView. FirstView is one which will be displayed in collapsible or normal mode and when user clicks on a cell it expands to show SecondView below FirstView.

In short if you see the UITableViewCell
   - FirstView has one child as UILabel, created using Autolayout and Size Classes
   - SecondView has 3 UILabel as subview, everything using the Autolayout and Size Classes.

Till now its as simple as creating the custom UITableViewCell nothing great about it. Lets start how we go about making this as Expandable/Collasible type Cell.

Since we will be hiding and showing the SecondView, all changes need to be made in SecondView. We will be playing with the Priority property of the Constraints.

  - Set the Height Constraint of the SecondView as 0 and set the Priority as 999.
  - For all the SubViews of SecondView set there constraint Priority as 998.

What this means is we have set the default height of SecondView as 0 and priority as 999 and its subviews priority as 998 which says that SecondView height property takes precedence over the internal constraints whose priority is less that height property.
Since initially we have set the heightconstraint with priority as 999 to 0, all subviews are collapsed or hidden.
Now when we click the cell we are setting the priority as 250 as below which is less then the priority of its subviews thus expanding the SecondView to show its subview.

In your customCell class, update the HeightConstraintProperty of SecondView on click as below.

      var showsDetails = false {
        didSet {
            heightConstraintSecondView.priority = showsDetails ? 250 : 999
        }
      }

In Your ViewController
     Implement the TableViewDelegates, in didSelectRowAtIndexPath set the indexPath.row to a variable and reload the cell using begin and end updates
     
      func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(selectedIndex == indexPath.row) {
            selectedIndex = -1
        } else {
            selectedIndex = indexPath.row
        }
        self.expandTableView.beginUpdates()
        self.expandTableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic )
        self.expandTableView.endUpdates()
      }
        
        
     In heightForRowAtIndexPath set the height of the cell accordingly for selectedIndex
         
        func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
          if(selectedIndex == indexPath.row) {
            return 100;
          } else {
            return 40;
          }
        }
