program demo_plot
use M_draw,  only : prefposition, prefsize, vinit, vsetflush, linewidth, vflush, vexit, getkey
use M_graph, only : graph_init, plot
real                         :: x(25),y(25,3)
integer                      :: i
integer                      :: idum
integer                      :: ixsize, iysize
type(plot)                   :: plt
   !  fill some arrays with data we can plot
   do i=1,25
      x(i)=i
      y(i,1)=i**2+5.0
      y(i,2)=i*20.0
      y(i,3)=(-3.0)*(i/4.0)**3
   enddo
   ! initialize graphics window
   ixsize=1200*.75
   iysize=900*.75
   call prefposition(0,0)
   call prefsize(ixsize,iysize)
   call vinit('X11')
   call vsetflush(.false.)

   call linewidth(20)

   call graph_init( 12.0, 9.0, 1.50, 1.50, 1.0 )
   call plt%table(x,y)

   call vflush()
   idum=getkey()
   call vexit()               ! close up plot package
end program demo_plot
