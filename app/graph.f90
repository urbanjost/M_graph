PROGRAM demo_graph
use m_graph, only : graph, graph_init
use M_draw
use M_msg,   only : str
implicit none

integer,PARAMETER            :: NUMLINES=3
integer,PARAMETER            :: NUMPTS=25
integer,PARAMETER            :: NF=255
REAL                         :: X(NUMPTS),Y(NUMPTS,NUMLINES)
CHARACTER(len=80)            :: C(NUMLINES+3)
INTEGER                      :: NC(NUMLINES+3)
REAL                         :: F(NF)
character(len=20)            :: device
integer                      :: ixsize
integer                      :: iysize
integer                      :: i20, i60, i70
integer                      :: ndp
integer                      :: ndl
!!character(len=:),allocatable :: filename
integer                      :: w
! create a NAMELIST group with lots of options
real :: view(3)=[0.0,0.0,0.0]
character(len=80) :: t='title'
character(len=80) :: fontname='roman'
logical :: h=.false.
real  ::  grid                       ;  equivalence(f(42),grid)                       ;  namelist  /args/grid
real  ::  symbol_connect             ;  equivalence(f(10),symbol_connect)             ;  namelist  /args/symbol_connect
real  ::  symbol_nth                 ;  equivalence(f(11),symbol_nth)                 ;  namelist  /args/symbol_nth
real  ::  symbol_size                ;  equivalence(f(12),symbol_size)                ;  namelist  /args/symbol_size
real  ::  symbol_start               ;  equivalence(f(13),symbol_start)               ;  namelist  /args/symbol_start
real  ::  error_bar_option           ;  equivalence(f(14),error_bar_option)           ;  namelist  /args/error_bar_option
real  ::  error_bar_size             ;  equivalence(f(16),error_bar_size)             ;  namelist  /args/error_bar_size
real  ::  x_axis_number_orientation  ;  equivalence(f(31),x_axis_number_orientation)  ;  namelist  /args/x_axis_number_orientation
real  ::  y_axis_number_orientation  ;  equivalence(f(32),y_axis_number_orientation)  ;  namelist  /args/y_axis_number_orientation
real  ::  x_axis_length              ;  equivalence(f(21),x_axis_length)              ;  namelist  /args/x_axis_length
real  ::  y_axis_length              ;  equivalence(f(22),y_axis_length)              ;  namelist  /args/y_axis_length
real  ::  x_axis_label_size          ;  equivalence(f(39),x_axis_label_size)          ;  namelist  /args/x_axis_label_size
real  ::  y_axis_label_size          ;  equivalence(f(40),y_axis_label_size)          ;  namelist  /args/y_axis_label_size
real  ::  top_title_size             ;  equivalence(f(41),top_title_size)             ;  namelist  /args/top_title_size
namelist /args/ view,t,h,fontname,f
character(len=:),allocatable :: status
!-----------------------------------------------------------------------------------------------------------------------------------
   device='x11'
   ixsize=1200*.75*0.5
   iysize=900*.75*0.5
   w=40
   if(device.eq.'x11')then
      call prefposition(0,0)
      call prefsize(ixsize,iysize)
   else
      call prefsize(ixsize,iysize)
      !!call voutput(str(filename,'_',int(a),'x',int(b),'.',device,sep=''))
   endif
   call vinit(device)
   call vsetflush(.false.)
   call vflush()
   call linewidth(w)
!-----------------------------------------------------------------------
!     FILL SOME ARRAYS WITH DATA WE CAN PLOT
   DO i20=1,25
      X(i20)=i20
      Y(i20,1)=i20**2+5.0
      Y(i20,2)=i20*20.0
      Y(i20,3)=(-3.0)*(i20/4.0)**3
   enddo
!-----------------------------------------------------------------------
   f=0.0 !     ZERO OUT OPTION ARRAY
!     SET UP COLOR AND LINETYPE IN OPTION ARRAY
   DO I70=55,NF,2
      F(I70)=mod(i70,7)
      F(I70-1)=mod(i70,7)
   enddo
   f(52)=1
   f(53)=1
!-----------------------------------------------------------------------
   NDP=NUMPTS! number of data points per line
   NDL=3     ! number of data lines
   !C        ! array of strings dimensioned C(3+NUMPTS)
   C(1)='X-AXIS'  !  c(1) : x axis title
   C(2)='Y-AXIS'  !  c(2) : y axis title
   C(3)='TITLE'  !  c(3) : top title
   C(4)='LABEL 1'  !  c(n) : line N-3 legend (optionally used)
   C(5)='LABEL 2'  !  c(n) : line N-3 legend (optionally used)
   C(6)='LABEL 3'  !  c(n) : line N-3 legend (optionally used)
   !NC       ! array of string lengths in c() dimensioned nc(3+NUMPTS)
   DO I60=1,6
      NC(I60)=LEN_TRIM(C(I60))
   enddo
   !f(39)= 0.25
   !f(40)= 0.25
   !f(42)= 3.00
   !f(43)=-1.00
!-----------------------------------------------------------------------
!  INITIALIZE GRAPHICS
   call graph_init(12.0,9.0, 1.00,1.00, 1.0)
   INFINITE: do
      CALL graph(X,Y,NDP,NDL,F,C,NC)
      call vflush()
888   continue
      call readargs(status) ! interactively change NAMELIST group
      if(status.eq.'stop')exit
      call vflush()              ! flush graphics buffers
      call color(7)
      call clear()
      call color(0)
      call vflush()              ! flush graphics buffers
   enddo INFINITE
!-----------------------------------------------------------------------------------------------------------------------------------
999 continue
   call vflush()              ! flush graphics buffers
   call vexit()               ! close up plot package
contains
   subroutine readargs(status)
      character(len=:),intent(out),allocatable :: status
      character(len=256) :: line
      character(len=256) :: answer
      integer            :: lun
      integer            :: ios
      status=''
      write(*,'(a)')'args>> "." to run, "stop" to end, "show" to show keywords'
      do
         write(*,'(a)',advance='no')'args>>'
         read(*,'(a)')line
         if(line(1:1).eq.'!')cycle
         select case(line)
          case('.')
            exit
          case('show')
            write(*,*)'SO FAR'
            write(*,nml=args)
            !! something where you could restrict nml output to just listed names would be nice
            !!write(*,nml=args)['A','H']
            !!write(*,nml=*NML)args['A','H']
          case('sh')
             call execute_command_line('bash')
          case('read')
             write(*,'(a)',advance='no')'filename:'
             read(*,'(a)',iostat=ios)answer
             if(ios.ne.0)exit
             open(file=answer,iostat=ios,newunit=lun)
             if(ios.ne.0)exit
             read(lun,args,iostat=ios)
             close(unit=lun,iostat=ios)
          case('stop')
            status='stop'
            exit
          case('write')
             write(*,'(a)',advance='no')'filename:'
             read(*,'(a)',iostat=ios)answer
             if(ios.ne.0)exit
             open(file=answer,iostat=ios,newunit=lun)
             if(ios.ne.0)exit
             write(lun,args,iostat=ios)
             close(unit=lun,iostat=ios)
          case default
            UPDATE: block
               character(len=:),allocatable :: intmp
               character(len=256)  :: message
               integer :: ios
               intmp='&ARGS '//trim(line)//'/'
               read(intmp,nml=args,iostat=ios,iomsg=message)
               if(ios.ne.0)then
                  write(*,*)'ERROR:',trim(message)
               endif
            endblock UPDATE
         end select
      enddo
   end subroutine readargs
end program demo_graph
