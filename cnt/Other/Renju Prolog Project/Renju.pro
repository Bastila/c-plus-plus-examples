/*****************************************************************************

		Copyright (c) Ivan Goremykin

 Project:  RENJU
 FileName: RENJU.PRO
 Purpose: Ivan Goremykin
 Written by: Visual Prolog
 Comments: AI termwork
******************************************************************************/

include "renju.inc"

global domains

   % ������� ��������
   Element = Integer 

   % ������ ���������
   ElementList = Element *

   % ���������� ������
   Array = array 
   (
		  Integer _Size,    % ������ �������
		  ElementList _List % ������ ���������
   )
   
   % ������� �� ���������
   ElementMatrix = ElementList * 

   % ���������� �������
   Square = square 
   (
		  Integer _Size,        % ������ �������
		  ElementMatrix _Square % ������ ���������
   )

global predicates
   renju()
 
% <Exported procedures ****************************************************************************************************************************************>  
   
	% �������� ���������� ���� ������������� ���������� (��������� ������ ������� �������)
	procedure export_execute_renju_ai_is_black
	(
		ElementList, % [IN]  ������� ��������� ������� �����
		Integer,     % [OUT] ������ ������ ����
		Integer      % [OUT] ������ ������� ����
	)
	-
	(
		i,
		o,
		o
	) language stdcall
   
	% �������� ���������� ���� ������������� ���������� (��������� ������ ������ �������)
	procedure export_execute_renju_ai_is_white
	(
		ElementList, % [IN]  ������� ��������� ������� �����
		Integer,     % [OUT] ������ ������ ����
		Integer      % [OUT] ������ ������� ����
	)
	-
	(
		i,
		o,
		o
	) language stdcall
   
	% �������� ���������� ���� ������������� ���������� (��������� ������ ������� �������) [���������� ������]
	procedure export_execute_renju_ai_is_black_debug
	(
		ElementList, % [IN]  ������� ��������� ������� �����
		ElementList, % [OUT] ������������ �����
		Integer,     % [OUT] ������ ������ ����
		Integer      % [OUT] ������ ������� ����
	)
	-
	(
		i,
		o,
		o,
		o
	) language stdcall
   
	% �������� ���������� ���� ������������� ���������� (��������� ������ ������ �������) [���������� ������]
	procedure export_execute_renju_ai_is_white_debug
	(
		ElementList,   % [IN]  ������� ��������� ������� �����
		ElementList,   % [OUT] ������������ �����
		Integer,       % [OUT] ������ ������ ����
		Integer        % [OUT] ������ ������� ����
	)
	-
	(
		i,
		o,
		o,
		o
	) language stdcall
   
	% �������� ���������� ����� ������ ��� ������-��������
	procedure export_execute_renju_human_is_black
	(
		ElementList, 	% [IN]  ������� ��������� ������� �����
		ElementList  	% [OUT] ������� ��������� ������� ����� � ������������ ������
	)
	-
	(
		i,
		o
	) language stdcall
   
	% ���������, ��������� �� ����
	procedure export_execute_renju_check_the_game_end
	(
		ElementList, 	% [IN] ������� ��������� ������� �����
		Integer       	% [OUT] 0 - ����� �� �������, -1 - ������ �������, -2 - ����� �������
	)
	-
	(
		i,
		o
	) language stdcall
   
	% ������������ �������� int
	procedure export_execute_test_export_int
	(
		Integer,   	%  [IN] ������� ��������� ������� �����
		Integer    	%  [OUT]
	)
	-
	(
		i,
		o
	) language stdcall
   
	% ������������ �������� list-�
	procedure export_execute_test_export_list
	(
		ElementList,   	%  [IN]
		ElementList    	%  [OUT] ������� ��������� ������� ����� � ������������ ������
	)
	-
	(
		i,
		o
	) language stdcall

% <\Exported procedures ****************************************************************************************************************************************>

   
predicates
% <Lists and arrays *****************************************************************************************************************************>

% <Convertation *****************************************************************************************************************************>  
	% ������������� ������ � ������� 15�15
	nondeterm convert_list_to_matrix
	(
		ElementList,		% [IN] ���� ��� ���������������
		ElementMatrix		% [OUT] �������� ���������� �������
	)
	-
	(
		i,
		o
	)

	% ������������� ������� 15�15 � ������	     
	nondeterm convert_matrix_to_list
	(
		ElementMatrix, 		% [IN] ���������� ������� ��� ���������������
		ElementList		% [OUT] �������� ���� 
	)
	-
	(
		i,
		o
	)
	
	%< ���������� �������� �������������� ����-�������>
	nondeterm transform
	(
		ElementList,
		ElementMatrix,
		Integer,
		Integer,
		ElementMatrix
	)
	-
	(
		i,
		i,
		i,
		i,
		o
	)
	
	% ����� ������� � �������, ��������� ���������� ���������� ��������
	nondeterm write_element_to_matrix
	(
		Element,		%[IN] ������������ �������
		ElementMatrix,		%[IN] �������� �������
		Integer,		%[IN] � ���������� ��� ������
		Integer,		%[IN] � ����������
		Integer,		%[OUT] � ���������� ��������� ������
		Integer,		%[OUT] � ���������� ��������� ������
		ElementMatrix		%[OUT] ������������� �������
	)
	-
	(
		i,
		i,
		i,
		i,
		o,
		o,
		o
	)

	% �������� ���� ����� � �������
	nondeterm copy_body
	(
		ElementList,		%[IN] ���������� ����
		ElementMatrix,		%[IN] �������� �������
		Integer,		%[IN] ��������� ����������
		Integer,		%[IN] � ������� (�������� 1;0, ��� ��� 0;0 - ������ ������)
		ElementList		%[OUT] ���������
	)
	-
	(
		i,
		i,
		i,
		i,
		o
	)
% <\Convertation *****************************************************************************************************************************>
   
	% ����� ����� ������
	nondeterm get_list_size
	(
		ElementList,		% [IN] ������
		Integer			% [OUT] ����� ������
	)
	-
	(
		i,
		o
	)

	% �������� �������� ������ �� ��� ������
	nondeterm get_list_element
	(
		ElementList,		% [IN] ������
		Integer,		% [IN] ������ �������� (���������� ���������� � 0)
		Element			% [OUT] ������� � ������ �������
	)
	-
	(
		i,
		i,
		o
	)

	% ��������� �������� ������ ����� ��������
	nondeterm set_list_element
	(
		ElementList,		%  [IN] ������
		Integer,		%  [IN] ������ �������� (���������� ���������� � 0)
		Element,		%  [IN] ����� �������� �������� � ������ �������
		ElementList		%  [OUT] �������������� ������
	)
	-
	(
		i,
		i,
		i,
		o
	)
   
	% �������� � ������ �����
	nondeterm append_to_list
	(
		ElementList,		%  [IN] ������� ������
		Element,		%  [IN]	������������ �������
		ElementList		%  [OUT] ���������
	)
	-
	(
		i,
		i,
		o
	)

	% ���������� ������
	nondeterm print_list
	(
		ElementList		% [IN] ������
	)
	-
	(
		i
	)

	% �������� ����� ����� �������
	nondeterm get_matrix_row_count
	(
		ElementMatrix,		% [IN] �������
		Integer			% [OUT] ���������� �����
	)
	-
	(
		i,
		o
	)

	% �������� ������ ������� �� � ������
	nondeterm get_matrix_row
	(
		ElementMatrix, 	% [IN] �������
		Integer, 	% [IN] ����� ������ (���������� ���������� � 0)
		ElementList	% [OUT] ������ �������
	)
	-
	(
		i,
		i,
		o
	)

	% ��������� ������ ������� ����� ��������
	nondeterm set_matrix_row
	(
		ElementMatrix,	% [IN] �������
		Integer,	% [IN] ����� ������ (���������� ���������� � 0)
		ElementList,	% [IN] ����� �������� ������ �������
		ElementMatrix	% [OUT] �������������� �������
	)
	-
	(
		i,
		i,
		i,
		o
	)

	% �������� ������� ������� �� ��� �����������
	nondeterm get_matrix_element
	(
		ElementMatrix,		% [IN] �������
		Integer,		% [IN] ����� ������ (���������� ���������� � 0)
		Integer,		% [IN] ����� ������� (���������� ���������� � 0)
		Element			% [OUT] ������� �������
	)
	-
	(
		i,
		i,
		i,
		o
	)

	% ��������� �������� ������� ����� ��������
	nondeterm set_matrix_element
	(
		ElementMatrix,		% [IN] �������
		Integer,		% [IN] ����� ������ (���������� ���������� � 0)
		Integer,		% [IN] ����� ������� (���������� ���������� � 0)
		Element,		% [IN] ����� �������� ��������
		ElementMatrix		% [OUT] ��������������� �������
	)
	-
	(
		i,
		i,
		i,
		i,
		o
	)
   
	% ���������� �������
	nondeterm copy_matrix
	(
		ElementMatrix,	% [IN] �������-��������
		ElementMatrix	% [OUT] �������-��������
	)
	-
	(
		i,
		o
	)
   
	% ������ �������
	nondeterm print_matrix
	(
		ElementMatrix	% [IN] �������
	)
	-
	(
		i
	)

	% ��������� ������
	nondeterm fill_array
	(
		ElementList,		% [IN] ������ ��� ����������
		Array			% [OUT] �������������� ������
	)
	-
	(
		i,
		o
	)

	% ���������� ������
	nondeterm copy_array
	(
		Array,			% [IN] ������-��������
		Array			% [OUT] ������-��������
		)
	-
	(
		i,
		o
	)

	% �������� ������� ������� �� ��� �������
	nondeterm get_array_element
	(
		Array,			% [IN] ������
		Integer,		% [IN] ������ �������� (���������� ���������� � 0)
		Element			% [OUT] ������� � ������ �������
	)
	-
	(
		i,
		i,
		o
	)

	% ��������� �������� ������� ����� ��������
	nondeterm set_array_element
	(
		Array,			% [IN] ������
		Integer,		% [IN] ������ �������� (���������� ���������� � 0)
		Element,		% [IN] ����� �������� ��������
		Array			% [OUT] �������������� ������
	)
	-
	(
		i,
		i,
		i,
		o
	)

	% �������� ������
	nondeterm print_array
	(
		Array			% [IN] ������
	)
	-
	(
		i
	)

	% ��������� ���������� �������
	nondeterm fill_square
	(
		ElementMatrix,		% [IN] ������ ��� ����������
		Square			% [OUT] �������������� ����������� �������
	)
	-
	(
		i,
		o
	)
	
	% ������� ������� �� ���������� �������
	nondeterm get_matrix_from_square
	(
		Square,			% �������� ���������� �������
		ElementMatrix	% ����������� �������
	)
	-
	(
		i,
		o
	)

	% ���������� ���������� �������
	nondeterm copy_square
	(
		Square,			% [IN] ���������� �������-��������
		Square			% [OUT] ���������� �������-��������
	)
	-
	(
		i,
		o
	)

	% �������� ������� ���������� �������
	nondeterm get_square_element
	(
		Square,			% [IN] ���������� �������
		Integer,		% [IN] ������ ������ ��������
		Integer,		% [IN] ������ ������� ��������
		Element			% [OUT] ������� � ������� ���������
	)
	-
	(
		i,
		i,
		i,
		o
	)

	% ��������� �������� ���������� ������� ����� ��������
	nondeterm set_square_element
	(
		Square,			% [IN] ���������� �������
		Integer,		% [IN] ������ ������ ��������
		Integer,		% [IN] ������ ������� ��������
		Element,		% [IN] ����� �������� ��������
		Square			% [OUT] �������������� ���������� �������
	)
	-
	(
		i,
		i,
		i,
		i,
		o
	)

	% �������� ������ ���������� �������
	nondeterm get_square_size
	(
		Square,			%  [IN] ���������� �������
		Integer			%  [OUT] ������ ���������� �������
	)
	-
	(
		i,
		o
	)

	% �������� ���������� ��������� ���������� �������
	nondeterm get_square_max_coordinates
	(
		Square,			% [IN] ���������� �������
		Integer,		% [OUT] ������ ������ ������������� ��������
		Integer			% [OUT] ������ ������� ������������� ��������
	)
	-
	(
		i,
		o,
		o
	)

	% �������� ���������� ��������� ���������� ������� (��������������� ����������� �������� - �������� �� �������)
	nondeterm get_square_max_coordinates_rows
	(
		Square,			% [IN] ���������� �������
		Integer,		% [IN] ������ ������ �������� ��������
		Integer,		% [IN] ������ ������� �������� ��������
		Integer,		% [IN] ������� ������ ������ ������������� ��������
		Integer,		% [IN] ������� ������ ������� ������������� ��������
		Integer,		% [OUT] ������ ������ ������ ������������� ��������
		Integer			% [OUT] ������ ������� ������ ������������� ��������
	)
	-
	(
		i,
		i,
		i,
		i,
		i,
		o,
		o
	)

	% �������� ���������� ��������� ���������� ������� (��������������� ����������� �������� - �������� �� ��������)
	nondeterm get_square_max_coordinates_columns
	(
		Square,			% [IN] ���������� �������
		Integer,		% [IN] ������ ������ �������� ��������
		Integer,		% [IN] ������ ������� �������� ��������
		Integer,		% [IN] ������� ������ ������ ������������� ��������
		Integer,		% [IN] ������� ������ ������� ������������� ��������
		Integer,		% [OUT] ������ ������ ������ ������������� ��������
		Integer			% [OUT] ������ ������� ������ ������������� ��������
	)
	-
	(
		i,
		i,
		i,
		i,
		i,
		o,
		o
	)

	% �������� � ���������� ������� ��� �������� ���������, ������ value1, �� value2
	nondeterm change_all_square_value1_to_value2
	(
		Square,			% [IN] ���������� �������
		Integer,		% [IN] ���������� �������� value1
		Integer,		% [IN] ���������� �������� value2
		Square			% [OUT] �������������� ���������� �������
	)
	-
	(
		i,
		i,
		i,
		o
	)

	% �������� � ���������� ������� ��� �������� ���������, ������ value1, �� value2 (��������������� ����������� �������� - �������� �� �������)
	nondeterm change_all_square_value1_to_value2_rows
	(
		Square,			% [IN] ���������� �������
		Integer,		% [IN] ������ ������ �������� ��������
		Integer,		% [IN] ������ ������� �������� ��������
		Integer,		% [IN] ���������� �������� value1
		Integer,		% [IN] ���������� �������� value2
		Square			% [OUT] �������������� ���������� �������
	)
	-
	(
		i,
		i,
		i,
		i,
		i,
		o
	)

	% �������� � ���������� ������� ��� �������� ���������, ������ value1, �� value2 (��������������� ����������� �������� - �������� �� ��������)
	nondeterm change_all_square_value1_to_value2_columns
	(
		Square,			% [IN] ���������� �������
		Integer,		% [IN] ������ ������ �������� ��������
		Integer,		% [IN] ������ ������� �������� ��������
		Integer,		% [IN] ���������� �������� value1
		Integer,		% [IN] ���������� �������� value2
		Square			% [OUT] �������������� ���������� �������
	)
	-
	(
		i,
		i,
		i,
		i,
		i,
		o
	)

	% ������ ���������� �������
	nondeterm print_square
	(
		Square			% [IN] ���������� �������
	)
	-
	(
		i
	)
   
% <\Lists and arrays *****************************************************************************************************************************>


% <Renju *****************************************************************************************************************************************>

% <   Next Step Board Generation ********************************************************************************************************************>

	% �������� ����� � ����������� ���������� ���������� ���������� ����
	nondeterm get_next_step_board
	(
		Square,			% [IN] ������� �����
		Square			% [OUT ]����� � ����������� ���������� ���������� ���������� ����
	)
	-
	(
		i,
		o
	)
   
	% ��������� ��� ������ ������� �������� ���������, ����� �������� ��������� �������� ���������� ����
	nondeterm get_next_step_board_rows
	(
		Integer,		% [IN] ������ ������� ������ ������� �������� ���������
		Integer,		% [IN] ����� ������� ������� �������� ���������
		Square,			% [IN] ������� �������� ���������
		Square			% [OUT] ������� � ����������� ���������� ���������� ���������� ����
	)
	-
	(
		i,
		i,
		i,
		o
	)
   
	% ��������� ��� ������� ������� ������ ������� �������� ���������, ����� �������� ��������� �������� ���������� ����
	nondeterm get_next_step_board_columns
	(
		Integer,		% [IN] ������ ������� ������ ������� �������� ���������
		Integer,		% [IN] ������ ������� ������� ������� �������� ���������
		Square,			% [IN] ������� �������� ���������
		Square			% [OUT] ������� � ����������� ���������� ���������� ���������� ����
	)
	-
	(
		i,
		i,
		i,
		o
	)
   
	% ���������� � ������� ���������� ����� ������������ ������ ��������� �����
	nondeterm set_next_step_star_center
	(
		Integer,		% [IN] ������ ������� ������ ������� �������� ���������
		Integer,		% [IN] ������ ������� ������� ������� �������� ���������
		Square,			% [IN] ������� �������� ���������
		Square			% [OUT] ������� � ����������� ���������� ���������� ���������� ����
	)
	-
	(
		i,
		i,
		i,
		o
	)
   
	% ���������� � ������� ���������� "�������" ���� ������������ ������ ��������� �����
	nondeterm set_next_step_star_ray_element
	(
		Integer,		% [IN] ������ ������� ������ ������� �������� ���������
		Integer,		% [IN] ������ ������� ������� ������� �������� ���������
		Square,			% [IN] ������� �������� ���������
		Square			% [OUT] ������� � ����������� ���������� ���������� ���������� ����
	)
	-
	(
		i,
		i,
		i,
		o
	)
   
% <   \Next Step Board Generation *******************************************************************************************************************>

% <   Marc Next Step Board ********************************************************************************************************************>
   
	% ������� ������������� ������� ���������� ����
	nondeterm get_marked_board
	(
		Square,			% [IN] ������� ��������� ������� ����� � ����������� ���������� ���������� ����
		Square			% [OUT] ������� ��������� ������� ����� � ���������� ���������� ���������� ����
	)
	-
	(
		i,
		o
	)

	nondeterm mark_func % ��������� �������
	(
		ElementMatrix Exist,			% [IN] ������� ������� ������������, -1- ���� �����, -2 - �����, 0 - �������� ������, -3 - ��������
		Integer RowNumber,			% [IN] ��������� ������. ������������ ������ ���������, ����� ������� � 0.
		ElementMatrix StartMarkMatrix,		% [IN] ��������� ������� ������
		ElementMatrix NewMarkMatrix		% [OUT] ������� ������
	)
	-
	(
		i,
		i,
		i,
		o
	)
	
	nondeterm mark_row % ��������� ������� ��� ������ � �������
	(
		ElementMatrix Exist,				% [IN] ������� ������� ������������, -1- ���� �����, -2 - �����, 0 - �������� ������, -3 - ��������
		Integer RowNumber,				% [IN] ����� ������
		Integer ColNumber,				% [IN] ��������� �������. ������������ ������ ���������, ����� ������� � 0.
		ElementMatrix StartMarkMatrix, 			% [IN] ��������� ������� ������
		ElementMatrix NewMarkMatrix			% [OUT] ������� ������
	)
	-
	(
		i,
		i,
		i,
		i,
		o
	)
	
	nondeterm mark_element % ������ ������ �������� �������
	(
		ElementMatrix Exist,			% [IN] ������� ������� ������������, -1- ���� �����, -2 - �����, 0 - �������� ������, -3 - ��������
		Integer RowNumber,			% [IN] ����� ������
		Integer ColNumber,			% [IN] ����� �������
		Element ResMark				% [OUT] ������
	)
	-
	(
		i,
		i,
		i,
		o
	)
		
	nondeterm is_not_changed % �������� �� ����� ����� � ����
	(
		Element StartMarkFriend,	% [IN] ������� ������ ��� �����
		Element StartMarkEnemy,		% [IN] ������� ������ ��� �����
		Element Elem			% [IN] �������� � ������
	)
	-
	(
		i,
		i,
		i
	)
		
	nondeterm find_left % ������������ ����� �����
	(
		ElementMatrix Exist,		% [IN] ������� ������� ������������, -1- ���� �����, -2 - �����, 0 - �������� ������, -3 - ��������
		Integer RowNumber,		% [IN] ����� ������
		Integer ColNumber,		% [IN] ����� �������
		Element StartMarkFriend,	% [IN] ��������� ������ ��� �����
		Element StartMarkEnemy,		% [IN] ��������� ������ ��� ���������
		Element NewMarkFriend,		% [OUT] �������� ������ ��� �����
		Element NewMarkEnemy		% [OUT] �������� ������ ��� ���������
	)
	-
	(
		i,
		i,
		i,
		i,
		i,
		o,
		o
	)
	nondeterm find_right % ������������ ����� ������
	(
		ElementMatrix Exist,		% [IN] ������� ������� ������������, -1- ���� �����, -2 - �����, 0 - �������� ������, -3 - ��������
		Integer RowNumber,		% [IN] ����� ������
		Integer ColNumber,		% [IN] ����� �������
		Element StartMarkFriend,	% [IN] ��������� ������ ��� �����
		Element StartMarkEnemy,		% [IN] ��������� ������ ��� ���������
		Element NewMarkFriend,		% [OUT] �������� ������ ��� �����
		Element NewMarkEnemy		% [OUT] �������� ������ ��� ���������
	)
	-
	(
		i,
		i,
		i,
		i,
		i,
		o,
		o
	)
	nondeterm find_up % ������������ ����� ������
	(
		ElementMatrix Exist,		% [IN] ������� ������� ������������, -1- ���� �����, -2 - �����, 0 - �������� ������, -3 - ��������
		Integer RowNumber,		% [IN] ����� ������
		Integer ColNumber,		% [IN] ����� �������
		Element StartMarkFriend,	% [IN] ��������� ������ ��� �����
		Element StartMarkEnemy,		% [IN] ��������� ������ ��� ���������
		Element NewMarkFriend,		% [OUT] �������� ������ ��� �����
		Element NewMarkEnemy		% [OUT] �������� ������ ��� ���������
	)
	-
	(
		i,
		i,
		i,
		i,
		i,
		o,
		o
	)
	nondeterm find_down % ������������ ����� �����
	(
		ElementMatrix Exist,		% [IN] ������� ������� ������������, -1- ���� �����, -2 - �����, 0 - �������� ������, -3 - ��������
		Integer RowNumber,		% [IN] ����� ������
		Integer ColNumber,		% [IN] ����� �������
		Element StartMarkFriend,	% [IN] ��������� ������ ��� �����
		Element StartMarkEnemy,		% [IN] ��������� ������ ��� ���������
		Element NewMarkFriend,		% [OUT] �������� ������ ��� �����
		Element NewMarkEnemy		% [OUT] �������� ������ ��� ���������
	)
	-
	(
		i,
		i,
		i,
		i,
		i,
		o,
		o
	)
	nondeterm find_left_up % ������������ ����� �����-������
	(
		ElementMatrix Exist,		% [IN] ������� ������� ������������, -1- ���� �����, -2 - �����, 0 - �������� ������, -3 - ��������
		Integer RowNumber,		% [IN] ����� ������
		Integer ColNumber,		% [IN] ����� �������
		Element StartMarkFriend,	% [IN] ��������� ������ ��� �����
		Element StartMarkEnemy,		% [IN] ��������� ������ ��� ���������
		Element NewMarkFriend,		% [OUT] �������� ������ ��� �����
		Element NewMarkEnemy		% [OUT] �������� ������ ��� ���������
	)
	-
	(
		i,
		i,
		i,
		i,
		i,
		o,
		o
	)
	nondeterm find_right_up % ������������ ����� ������-������
	(
		ElementMatrix Exist,		% [IN] ������� ������� ������������, -1- ���� �����, -2 - �����, 0 - �������� ������, -3 - ��������
		Integer RowNumber,		% [IN] ����� ������
		Integer ColNumber,		% [IN] ����� �������
		Element StartMarkFriend,	% [IN] ��������� ������ ��� �����
		Element StartMarkEnemy,		% [IN] ��������� ������ ��� ���������
		Element NewMarkFriend,		% [OUT] �������� ������ ��� �����
		Element NewMarkEnemy		% [OUT] �������� ������ ��� ���������
	)
	-
	(
		i,
		i,
		i,
		i,
		i,
		o,
		o
	)
	nondeterm find_right_down % ������������ ����� ������-������
	(
		ElementMatrix Exist,		% [IN] ������� ������� ������������, -1- ���� �����, -2 - �����, 0 - �������� ������, -3 - ��������
		Integer RowNumber,		% [IN] ����� ������
		Integer ColNumber,		% [IN] ����� �������
		Element StartMarkFriend,	% [IN] ��������� ������ ��� �����
		Element StartMarkEnemy,		% [IN] ��������� ������ ��� ���������
		Element NewMarkFriend,		% [OUT] �������� ������ ��� �����
		Element NewMarkEnemy		% [OUT] �������� ������ ��� ���������
	)
	-
	(
		i,
		i,
		i,
		i,
		i,
		o,
		o
	)
	nondeterm find_left_down % ������������ ����� �����-������
	(
		ElementMatrix Exist,		% [IN] ������� ������� ������������, -1- ���� �����, -2 - �����, 0 - �������� ������, -3 - ��������
		Integer RowNumber,		% [IN] ����� ������
		Integer ColNumber,		% [IN] ����� �������
		Element StartMarkFriend,	% [IN] ��������� ������ ��� �����
		Element StartMarkEnemy,		% [IN] ��������� ������ ��� ���������
		Element NewMarkFriend,		% [OUT] �������� ������ ��� �����
		Element NewMarkEnemy		% [OUT] �������� ������ ��� ���������
	)
	-
	(
		i,
		i,
		i,
		i,
		i,
		o,
		o
	)
	nondeterm add_mark_for_element % ������ ���������� ����� ��� ������ ������
	(
		Element Elem,			% [IN] �������� � ������
		Element StartMarkFriend,	% [IN] ��������� ������ ��� �����
		Element StartMarkEnemy,		% [IN] ��������� ������ ��� ���������
		Element AddMarkFriend,		% [OUT] �������� ������ ��� �����
		Element AddMarkEnemy		% [OUT] �������� ������ ��� ���������
	)
	-
	(
		i,
		i,
		i,
		o,
		o
	)
% <   \Marc Next Step Board ********************************************************************************************************************>   
   
% <   Arbitrator ************************************************************************************************************************************>
	% �������� �� ����. ���� - ������
	nondeterm get_checked_next_step_board
	(
		Square NextStepBoardState, 		% [IN]�������� ������� ������������
		Square CheckedNextStepBoardState	% [OUT] ����������� ������ � ������ �����
	)
	-
	(
		i,
		o
	)
	
	% �������� �� ���� ���� �������		
	nondeterm check_func
	(
		ElementMatrix Exist,		% [IN] ������� ������� ������������, -1- ���� �����, -2 - �����, 0 - �������� ������, -3 - ��������
		Integer RowNumber,		% [IN] ��������� ������. ������������ ������ ���������, ����� ������� � 0.
		ElementMatrix StartMatrix,	% [IN] ��������� ������� ������������
		ElementMatrix NewMatrix		% [OUT] ������� ������������
	)
	-
	(
		i,
		i,
		i,
		o
	)
	
	% �������� �� ���� ����� ������		
	nondeterm check_row
	(
		ElementMatrix Exist,		% [IN] ������� ������� ������������, -1- ���� �����, -2 - �����, 0 - �������� ������, -3 - ��������
		Integer RowNumber,		% [IN] ����� ������
		Integer ColNumber,		% [IN] ��������� �������. ������������ ������ ���������, ����� ������� � 0.
		ElementMatrix StartMatrix, 	% [IN] ��������� ������� ������
		ElementMatrix NewMatrix		% [OUT] ������� ������������
	)
	-
	(
		i,
		i,
		i,
		i,
		o
	)
   
	% �������� �� ���� ������ ��������		
	nondeterm check_element
	(
		ElementMatrix Exist,	% [IN] ������� ������� ������������, -1- ���� �����, -2 - �����, 0 - �������� ������, -3 - ��������
		Integer RowNumber,	% [IN] ����� ������
		Integer ColNumber,	% [IN] ����� �������
		Element CheckState	% [OUT] ���������� �������
	)
	-
	(
		i,
		i,
		i,
		o
	)

	% ��������, ��������� �� ����
	nondeterm test_func
	(
		ElementMatrix,			% ������� � ����������
		Integer,			% ���������������, ��������������� � 0
		Integer				% ��������� -1 - �������� ����, -2 - �����, 0 - �����
	)
	-
	(
		i,
		i,
		o
	)
	
	% �������� ��������� ������ �� ���������� ����� ����
	nondeterm test_row
	(
		ElementMatrix,			% ������� ���������
		Integer,			% ����� ������
		Integer,			% ���������������, ��������������� � 0
		Integer				% ����������
	)
	-
	(
		i,
		i,
		i,
		o
	)
	
	% ��������� ������� �� ��������� � ���������� ����� ����
	nondeterm test_element
	(
		ElementMatrix,			% ������� ���������
		Integer,			% ����� ������
		Integer,			% ����� �������
		Integer				% ���������
	)
	-
	(
		i,
		i,
		i,
		o
	)
	
	% ����� ���������� ���������� ������ ��������
	nondeterm find_win
	(
		Integer,				% ��� �������� -1, -2
		ElementMatrix,				% ������� ���������
		Integer,				% ����������
		Integer,				% --/--
		Integer					% ����������
	)
	-
	(
		i,
		i,
		i,
		i,
		o
	)
	
	%< �������� �� ���������� �������� �� ���� ������ ������������>
	nondeterm find_win_l
	(
		Integer,
		ElementMatrix,
		Integer,
		Integer,
		Integer
	)
	-
	(
		i,
		i,
		i,
		i,
		o
	)
	
	nondeterm find_win_r
	(
		Integer,
		ElementMatrix,
		Integer,
		Integer,
		Integer
	)
	-
	(
		i,
		i,
		i,
		i,
		o
	)
	
	nondeterm find_win_u
	(
		Integer,
		ElementMatrix,
		Integer,
		Integer,
		Integer
	)
	-
	(
		i,
		i,
		i,
		i,
		o
	)
	
	nondeterm find_win_d
	(
		Integer,
		ElementMatrix,
		Integer,
		Integer,
		Integer
	)
	-
	(
		i,
		i,
		i,
		i,
		o
	)
	
	nondeterm find_win_lu
	(
		Integer,
		ElementMatrix,
		Integer,
		Integer,
		Integer
	)
	-
	(
		i,
		i,
		i,
		i,
		o
	)
	
	nondeterm find_win_ld
	(
		Integer,
		ElementMatrix,
		Integer,
		Integer,
		Integer
	)
	-
	(
		i,
		i,
		i,
		i,
		o
	)
	
	nondeterm find_win_ru
	(
		Integer,
		ElementMatrix,
		Integer,
		Integer,
		Integer
	)
	-
	(
		i,
		i,
		i,
		i,
		o
	)
	
	nondeterm find_win_rd
	(
		Integer,
		ElementMatrix,
		Integer,
		Integer,
		Integer
	)
	-
	(
		i,
		i,
		i,
		i,
		o
	)
   %<\ �������� �� ���������� �������� �� ���� ������ ������������>
   
% <   \Arbitrator ************************************************************************************************************************************>

% <   Execute Renju ************************************************************************************************************************************>
	% �������� ���������� ���� ������������� ���������� (��������� ������ ������� �������)
	nondeterm execute_renju_ai_is_black
	(
		ElementMatrix,			% [IN]  ������� ��������� ������� �����
		Integer,			% [OUT] ������ ������ ����
		Integer				% [OUT] ������ ������� ����
	)
	-
	(
		i,
		o,
		o
	)
   
	% �������� ���������� ���� ������������� ���������� (��������� ������ ������ �������)
	nondeterm execute_renju_ai_is_white
	(
		ElementMatrix,			% [IN]  ������� ��������� ������� �����
		Integer,			% [OUT] ������ ������ ����
		Integer				% [OUT] ������ ������� ����
	)
	-
	(
		i,
		o,
		o
	)
   
	% �������� ���������� ���� ������������� ���������� (��������� ������ ������� �������) [���������� ������]
	nondeterm execute_renju_ai_is_black_debug
	(
		ElementMatrix,			% [IN]  ������� ��������� ������� �����
		ElementMatrix,			% [OUT] ������������ �����
		Integer,			% [OUT] ������ ������ ����
		Integer				% [OUT] ������ ������� ����
	)
	-
	(
		i,
		o,
		o,
		o
	)
   
	% �������� ���������� ���� ������������� ���������� (��������� ������ ������ �������) [���������� ������]
	nondeterm execute_renju_ai_is_white_debug
	(
		ElementMatrix,			% [IN]  ������� ��������� ������� �����
		ElementMatrix,			% [OUT] ������������ �����
		Integer,			% [OUT] ������ ������ ����
		Integer				% [OUT] ������ ������� ����
	)
	-
	(
		i,
		o,
		o,
		o
	)
   
	% �������� ���������� ����� ������ ��� ������-��������
	nondeterm execute_renju_human_is_black
	(
		ElementMatrix,		%  [IN]  ������� ��������� ������� �����
		ElementMatrix		%  [OUT] ������� ��������� ������� ����� � ������������ ������
	)
	-
	(
		i,
		o
	)
   
	% ���������, ��������� �� ����
	nondeterm execute_renju_check_the_game_end
	(
		ElementMatrix,			% [IN] ������� ��������� ������� �����
		Integer				% [OUT] 0 - ����� �� �������, -1 - ���� �������, -2 - ����� �������
	)
	-
	(
		i,
		o
	)
% <\Execute Renju  ************************************************************************************************************************************>

% <\Renju *****************************************************************************************************************************************>

clauses
	renju():-!.
% <Lists and arrays *****************************************************************************************************************************>
   
% <Convertation *****************************************************************************************************************************>  
	convert_list_to_matrix(List,ResultMatrix):-
			SourceMatrix = 
					[[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
					[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]],
			transform(List,SourceMatrix,0,0,ResultMatrix),
			!.
	
	transform([],SourceMatrix,_,_,SourceMatrix):-
			!.	
	
	transform([H|T],SourceMatrix,X,Y,ResultMatrix):-
			write_element_to_matrix(H,SourceMatrix,X,Y,NX,NY,ResultMatrix2),
			transform(T,ResultMatrix2,NX,NY,ResultMatrix),
			!.
			
	write_element_to_matrix(Elem,SourceMatrix,X,Y,NX,Y,ResultMatrix):-
			X < 15,
			Y < 15,
			NX = X + 1,
			set_matrix_element(SourceMatrix,Y,X,Elem,ResultMatrix),
			!.
			
	write_element_to_matrix(Elem,SourceMatrix,X,Y,NX,NY,ResultMatrix):-
			X >= 15,
			Y < 15,
			NX2 = 0,
			NY2 = Y + 1,
			write_element_to_matrix(Elem,SourceMatrix,NX2,NY2,NX,NY,ResultMatrix),
			!.
			
	write_element_to_matrix(_,SourceMatrix,_,Y,0,0,SourceMatrix):-
			Y >= 15,
			!.
		
	convert_matrix_to_list(SourceMatrix, ResultList):-
			get_matrix_element(SourceMatrix,0,0,Head),
			append_to_list([],Head,TempResult),
			copy_body(TempResult,SourceMatrix,1,0,ResultList),
			!.
	
	copy_body(StartList,SourceMatrix,X,Y,ResultList):-
			get_matrix_row_count(SourceMatrix,SSize),
			X < SSize,
			Y < SSize,
			get_matrix_element(SourceMatrix,Y,X,Elem),
			append_to_list(StartList,Elem,TempResult),
			X2 = X + 1,
			copy_body(TempResult,SourceMatrix,X2,Y,ResultList),
			!.
			
	copy_body(StartList,SourceMatrix,X,Y,ResultList):-
			get_matrix_row_count(SourceMatrix,SSize),
			X >= SSize,
			Y < SSize,
			X2 = 0,
			Y2 = Y + 1,
			copy_body(StartList,SourceMatrix,X2,Y2,ResultList),
			!.
			
	copy_body(StartList,SourceMatrix,_,Y,ResultList):-
			get_matrix_row_count(SourceMatrix,SSize),
			Y >= SSize,
			ResultList = StartList,
			!.
		
	append_to_list([], X, [X]):-!.
	
   	append_to_list([H|T], X, OutputList):-
   			append_to_list(T, X, New_T),
   			OutputList = [H|New_T].
% <\Convertation *****************************************************************************************************************************>  
   
	% ����� ����� ������
	get_list_size([], Size):-
			Size = 0,
			!.
	get_list_size([_ | EL_T], NewSize):-
			get_list_size(EL_T, Size),
			NewSize = Size + 1,
			!.

	% ����� ������� ������ �� ��� ������
	get_list_element([EL_H | _], 0, EL_H):-
			!.
	        
	get_list_element([_ | EL_T], Index, E):-
			Index >= 0,
			NewIndex = Index - 1,
			get_list_element(EL_T, NewIndex, E),
			!.

	% ��������� �������� ������ ����� ��������
	set_list_element([_ | EL_T], 0, E, [E | EL_T]):-
			!.
	                    
	set_list_element([EL_H | EL_T], Index, E, [EL_H | New_EL_T]):-
			Index >= 0,
			NewIndex = Index - 1,
			set_list_element(EL_T, NewIndex, E, New_EL_T),
			!.

	% �������� ������
	print_list([]):-
			!.
	print_list([EL_H | EL_T]):-
			  write(" "),
			  write(EL_H),
			  print_list(EL_T),
			!.

	% �������� ���������� ����� �������
	get_matrix_row_count([], 0):-
			!.
	        
	get_matrix_row_count([_ | EM_T], NewSize):-
			get_matrix_row_count(EM_T, Size),
			NewSize = Size + 1,
			!.

	% �������� ������ ������� �� �� ������
	get_matrix_row([EM_H | _], 0, EM_H):-
			!.
	                    
	get_matrix_row([_ | EM_T], Index, R):-
			Index >= 0,
			NewIndex = Index - 1,
			get_matrix_row(EM_T, NewIndex, R),
			!.

	% ��������� ������ ������� ����� ��������
	set_matrix_row([_ | EM_T], 0, R, [R | EM_T]):-
			!.
			
	set_matrix_row([EM_H | EM_T], Index, R, [EM_H | New_EM_T]):-
			Index >= 0,
			NewIndex = Index - 1,
			set_matrix_row(EM_T, NewIndex, R, New_EM_T),
			!.

	% �������� ������� ������� �� ��� �����������
	get_matrix_element(EM, RowIndex, ColumnIndex, Element):-
			get_matrix_row(EM, RowIndex, R),
			get_list_element(R, ColumnIndex, Element),
			!.

	% ��������� �������� ������� ����� ��������
	set_matrix_element(EM, RowIndex, ColumnIndex, Element, New_EM):-
			get_matrix_row(EM, RowIndex, R),
			set_list_element(R, ColumnIndex, Element, New_R),
			set_matrix_row(EM, RowIndex, New_R, New_EM),
			!.
	 
	% ���������� �������
	copy_matrix(Matrix,Matrix):-
			!.

	% �������� �������
	print_matrix([]):-
			!.
	        
	print_matrix([EM_H | EM_T]):-
			print_list(EM_H),
			nl,
			print_matrix(EM_T),
			!.

	% ��������� ������
	fill_array(EL, array(Size, EL)):-
			get_list_size(EL, Size),
			!.

	% ���������� ������
	copy_array(array(Size, List), array(Size, List)):-
			!.

	% ����� ������� ������� �� ��� �������
	get_array_element(array(_, EL), Index, E):-
			get_list_element(EL, Index, E),
			!.

	% ��������� �������� ������� ����� ��������
	set_array_element(array(Size, EL), Index, E, array(Size, New_EL)):-
			set_list_element(EL, Index, E, New_EL),
			!.

	% �������� ������
	print_array(array(Size, List)):-
			write(Size),
			write(":"),
			print_list(List),
			nl,
			!.

	% ����������� ���������� �������
	fill_square(EM, square(Size, EM)):-
			get_matrix_row_count(EM, Size),
			!.

	% ���������� ���������� �������
	copy_square(square(Size, Matrix), square(Size, Matrix)):-
			!.

	% �������� ������� ���������� ������� �� ��� ��������
	get_square_element(square(_, EM), RowIndex, ColumnIndex, E):-
			get_matrix_element(EM, RowIndex, ColumnIndex, E),
			!.

	% ��������� �������� ���������� ������� ����� ��������
	set_square_element(square(Size, EM), RowIndex, ColumnIndex, E, square(Size, New_EM)):-
			set_matrix_element(EM, RowIndex, ColumnIndex, E, New_EM),
			!.
	                                                                                     
	% �������� ������ ���������� �������
	get_square_size(square(Size, _), Size):-
			!.

	% �������� ���������� ��������� ���������� �������
	get_square_max_coordinates(Square, MaxRowIndex, MaxColumnIndex):-
			get_square_size(Square, BoardSize),
			BoardIndexSize = BoardSize - 1,
			get_square_max_coordinates_rows(Square, BoardIndexSize, BoardIndexSize, BoardIndexSize, BoardIndexSize, MaxRowIndex, MaxColumnIndex),
			!.

	% �������� ���������� ��������� ���������� ������� (��������������� ����������� ��������)
	get_square_max_coordinates_rows(_, -1, _, CurrentMaxRowIndex, CurrentMaxColumnIndex, CurrentMaxRowIndex, CurrentMaxColumnIndex):-
			!.
			
	get_square_max_coordinates_rows(Square, CurrentRowIndex, CurrentColumnIndex, CurrentMaxRowIndex, CurrentMaxColumnIndex, NewMaxRowIndex, NewMaxColumnIndex):-
			get_square_max_coordinates_columns(Square, CurrentRowIndex, CurrentColumnIndex, CurrentMaxRowIndex, CurrentMaxColumnIndex, TmpNewMaxRowIndex, TmpNewMaxColumnIndex),
			NextRowIndex = CurrentRowIndex - 1,
			get_square_max_coordinates_rows(Square, NextRowIndex, CurrentColumnIndex, TmpNewMaxRowIndex, TmpNewMaxColumnIndex, NewMaxRowIndex, NewMaxColumnIndex),
			!.
	  
	% �������� ���������� ��������� ���������� ������� (��������������� ����������� ��������)
	get_square_max_coordinates_columns(_, _, -1, CurrentMaxRowIndex, CurrentMaxColumnIndex, CurrentMaxRowIndex, CurrentMaxColumnIndex):-
			!.
			
	get_square_max_coordinates_columns(Square, CurrentRowIndex, CurrentColumnIndex, CurrentMaxRowIndex, CurrentMaxColumnIndex, NewMaxRowIndex, NewMaxColumnIndex):-
			get_square_element(Square, CurrentRowIndex, CurrentColumnIndex, CurrentValue),
			get_square_element(Square, CurrentMaxRowIndex, CurrentMaxColumnIndex, CurrentMaxValue),
			CurrentMaxValue > CurrentValue,
			NextColumnIndex = CurrentColumnIndex - 1,
			get_square_max_coordinates_columns(Square, CurrentRowIndex, NextColumnIndex, CurrentMaxRowIndex, CurrentMaxColumnIndex, NewMaxRowIndex, NewMaxColumnIndex),
			!.
	get_square_max_coordinates_columns(Square, CurrentRowIndex, CurrentColumnIndex, CurrentMaxRowIndex, CurrentMaxColumnIndex, NewMaxRowIndex, NewMaxColumnIndex):-
			get_square_element(Square, CurrentRowIndex, CurrentColumnIndex, CurrentValue),
			get_square_element(Square, CurrentMaxRowIndex, CurrentMaxColumnIndex, CurrentMaxValue),
			CurrentMaxValue <= CurrentValue,
			NextColumnIndex = CurrentColumnIndex - 1,
			get_square_max_coordinates_columns(Square, CurrentRowIndex, NextColumnIndex, CurrentRowIndex, CurrentColumnIndex, NewMaxRowIndex, NewMaxColumnIndex),
			!.

	% �������� � ���������� ������� ��� �������� ���������, ������ value1, �� value2
	change_all_square_value1_to_value2(Square1, Value1, Value2, Square2):-
			get_square_size(Square1, SquareSize),
			SquareIndexSize = SquareSize - 1,
			change_all_square_value1_to_value2_rows(Square1, SquareIndexSize, SquareIndexSize, Value1, Value2, Square2),
			!.
	                                                                     

	% �������� � ���������� ������� ��� �������� ���������, ������ value1, �� value2 (��������������� ����������� �������� - �������� �� �������)
	change_all_square_value1_to_value2_rows(Square1, -1, _, _, _, Square1):-
			!.
	                    
	change_all_square_value1_to_value2_rows(Square1, CurrentRowIndex, CurrentColumnIndex, Value1, Value2, Square2):-
			change_all_square_value1_to_value2_columns(Square1, CurrentRowIndex, CurrentColumnIndex, Value1, Value2, TmpSquare1),
			NextRowIndex = CurrentRowIndex - 1,
			change_all_square_value1_to_value2_rows(TmpSquare1, NextRowIndex, CurrentColumnIndex, Value1, Value2, Square2),
			!.

	% �������� � ���������� ������� ��� �������� ���������, ������ value1, �� value2 (��������������� ����������� �������� - �������� �� ��������)
	change_all_square_value1_to_value2_columns(Square1, _, -1, _, _, Square1):-
			!.
	                    
	change_all_square_value1_to_value2_columns(Square1, CurrentRowIndex, CurrentColumnIndex, Value1, Value2, Square2):-
			get_square_element(Square1, CurrentRowIndex, CurrentColumnIndex, CurrentValue),
			CurrentValue <= Value1,
			CurrentValue >= Value1,
			set_square_element(Square1, CurrentRowIndex, CurrentColumnIndex, Value2, TmpSquare1),
			NextColumnIndex = CurrentColumnIndex - 1,
			change_all_square_value1_to_value2_columns(TmpSquare1, CurrentRowIndex, NextColumnIndex, Value1, Value2, Square2),
			!.
	change_all_square_value1_to_value2_columns(Square1, CurrentRowIndex, CurrentColumnIndex, Value1, Value2, Square2):-
			get_square_element(Square1, CurrentRowIndex, CurrentColumnIndex, CurrentValue),
			CurrentValue < Value1,
			NextColumnIndex = CurrentColumnIndex - 1,
			change_all_square_value1_to_value2_columns(Square1, CurrentRowIndex, NextColumnIndex, Value1, Value2, Square2),
			!.
	change_all_square_value1_to_value2_columns(Square1, CurrentRowIndex, CurrentColumnIndex, Value1, Value2, Square2):-
			get_square_element(Square1, CurrentRowIndex, CurrentColumnIndex, CurrentValue),
			CurrentValue > Value1,
			NextColumnIndex = CurrentColumnIndex - 1,
			change_all_square_value1_to_value2_columns(Square1, CurrentRowIndex, NextColumnIndex, Value1, Value2, Square2),
			!.                                                                                                         

   % ������ ���������� �������
	print_square(square(Size, EM)):-
			write(Size),
			write(":"),
			nl,
			print_matrix(EM),
			!.

% <\Lists and arrays *****************************************************************************************************************************>

% <Renju *****************************************************************************************************************************************>

% <Next Step Board Generation ********************************************************************************************************************>

	% �������� ����� � ����������� ���������� ���������� ���������� ����
	get_next_step_board(CurrentBoardState, NextStepBoardState):-
			get_square_size(CurrentBoardState, BoardSize),
			MaxBoardIndex = BoardSize - 1,
			get_next_step_board_rows(MaxBoardIndex, MaxBoardIndex, CurrentBoardState, NextStepBoardState),
			!.
	                                                           
	% ��������� ��� ������ ������� �������� ���������, ����� �������� ��������� �������� ���������� ����
	get_next_step_board_rows(-1, _, CurrentBoardState, CurrentBoardState):-
			!.
			
	get_next_step_board_rows(CurrentRowIndex, ColumnCount, CurrentBoardState, NextStepBoardState):-
			get_next_step_board_columns(CurrentRowIndex, ColumnCount, CurrentBoardState, TmpNextStepBoardState),
			NextRowIndex = CurrentRowIndex - 1,
			get_next_step_board_rows(NextRowIndex, ColumnCount, TmpNextStepBoardState, NextStepBoardState),
			!.
	                                                                                              
	% ��������� ��� ������� ������� ������ ������� �������� ���������, ����� �������� ��������� �������� ���������� ����
	get_next_step_board_columns(_, -1, CurrentBoardState, CurrentBoardState):-
			!.
			
	get_next_step_board_columns(CurrentRowIndex, CurrentColumnIndex, CurrentBoardState, NextStepBoardState):-
			set_next_step_star_center(CurrentRowIndex, CurrentColumnIndex, CurrentBoardState, TmpNextStepBoardState),
			NextColumnIndex = CurrentColumnIndex - 1,
			get_next_step_board_columns(CurrentRowIndex, NextColumnIndex, TmpNextStepBoardState, NextStepBoardState),
			!.

	% ���������� � ������� ���������� ����� ������������ ������ ��������� �����
	set_next_step_star_center(RowIndex, ColumnIndex, CurrentBoardState, NextStepBoardState):-
			get_square_element(CurrentBoardState, RowIndex, ColumnIndex, CurrentElement),
			CurrentElement < -2,
			copy_square(CurrentBoardState, NextStepBoardState),
			!.
	        
	set_next_step_star_center(RowIndex, ColumnIndex, CurrentBoardState, NextStepBoardState):-
			get_square_element(CurrentBoardState, RowIndex, ColumnIndex, CurrentElement),
			CurrentElement > -1,
			copy_square(CurrentBoardState, NextStepBoardState),
			!.
			
	set_next_step_star_center(RowIndex, ColumnIndex, CurrentBoardState, NextStepBoardState):-
			get_square_element(CurrentBoardState, RowIndex, ColumnIndex, CurrentElement),
			CurrentElement <= -1,   
			CurrentElement >= -2,   

			RowIndexPlus1 = RowIndex + 1,
			RowIndexPlus2 = RowIndex + 2,
			RowIndexPlus3 = RowIndex + 3,
			RowIndexMinus1 = RowIndex - 1,
			RowIndexMinus2 = RowIndex - 2,
			RowIndexMinus3 = RowIndex - 3,

			ColumnIndexPlus1 = ColumnIndex + 1,
			ColumnIndexPlus2 = ColumnIndex + 2,
			ColumnIndexPlus3 = ColumnIndex + 3,
			ColumnIndexMinus1 = ColumnIndex - 1,
			ColumnIndexMinus2 = ColumnIndex - 2,
			ColumnIndexMinus3 = ColumnIndex - 3,

			% PI/2
			set_next_step_star_ray_element(RowIndexPlus1, ColumnIndex, CurrentBoardState, NextStepBoardState1),
			set_next_step_star_ray_element(RowIndexPlus2, ColumnIndex, NextStepBoardState1, NextStepBoardState2),
			set_next_step_star_ray_element(RowIndexPlus3, ColumnIndex, NextStepBoardState2, NextStepBoardState3),

			% PI/4
			set_next_step_star_ray_element(RowIndexPlus1, ColumnIndexPlus1, NextStepBoardState3, NextStepBoardState4),
			set_next_step_star_ray_element(RowIndexPlus2, ColumnIndexPlus2, NextStepBoardState4, NextStepBoardState5),
			set_next_step_star_ray_element(RowIndexPlus3, ColumnIndexPlus3, NextStepBoardState5, NextStepBoardState6),

			% 0
			set_next_step_star_ray_element(RowIndex, ColumnIndexPlus1, NextStepBoardState6, NextStepBoardState7),
			set_next_step_star_ray_element(RowIndex, ColumnIndexPlus2, NextStepBoardState7, NextStepBoardState8),
			set_next_step_star_ray_element(RowIndex, ColumnIndexPlus3, NextStepBoardState8, NextStepBoardState9),

			% -PI/4
			set_next_step_star_ray_element(RowIndexMinus1, ColumnIndexPlus1, NextStepBoardState9, NextStepBoardState10),
			set_next_step_star_ray_element(RowIndexMinus2, ColumnIndexPlus2, NextStepBoardState10, NextStepBoardState11),
			set_next_step_star_ray_element(RowIndexMinus3, ColumnIndexPlus3, NextStepBoardState11, NextStepBoardState12),

			% -PI/2
			set_next_step_star_ray_element(RowIndexMinus1, ColumnIndex, NextStepBoardState12, NextStepBoardState13),
			set_next_step_star_ray_element(RowIndexMinus2, ColumnIndex, NextStepBoardState13, NextStepBoardState14),
			set_next_step_star_ray_element(RowIndexMinus3, ColumnIndex, NextStepBoardState14, NextStepBoardState15),

			% -3*PI/4
			set_next_step_star_ray_element(RowIndexMinus1, ColumnIndexMinus1, NextStepBoardState15, NextStepBoardState16),
			set_next_step_star_ray_element(RowIndexMinus2, ColumnIndexMinus2, NextStepBoardState16, NextStepBoardState17),
			set_next_step_star_ray_element(RowIndexMinus3, ColumnIndexMinus3, NextStepBoardState17, NextStepBoardState18),

			% PI
			set_next_step_star_ray_element(RowIndex, ColumnIndexMinus1, NextStepBoardState18, NextStepBoardState19),
			set_next_step_star_ray_element(RowIndex, ColumnIndexMinus2, NextStepBoardState19, NextStepBoardState20),
			set_next_step_star_ray_element(RowIndex, ColumnIndexMinus3, NextStepBoardState20, NextStepBoardState21),

			% 3*PI/4
			set_next_step_star_ray_element(RowIndexPlus1, ColumnIndexMinus1, NextStepBoardState21, NextStepBoardState22),
			set_next_step_star_ray_element(RowIndexPlus2, ColumnIndexMinus2, NextStepBoardState22, NextStepBoardState23),
			set_next_step_star_ray_element(RowIndexPlus3, ColumnIndexMinus3, NextStepBoardState23, NextStepBoardState),
			!.
	             
	% ���������� � ������� ���������� "�������" ���� ������������ ������ ��������� �����
	set_next_step_star_ray_element(RowIndex, _, CurrentBoardState, NextStepBoardState):-
			RowIndex < 0,
			copy_square(CurrentBoardState, NextStepBoardState),
			!.
			
	set_next_step_star_ray_element(RowIndex, _, CurrentBoardState, NextStepBoardState):-
			get_square_size(CurrentBoardState, Size),
			RowIndex >= Size,
			copy_square(CurrentBoardState, NextStepBoardState),
			!.
			
	set_next_step_star_ray_element(_, ColumnIndex, CurrentBoardState, NextStepBoardState):-
			ColumnIndex < 0,
			copy_square(CurrentBoardState, NextStepBoardState),
			!.
			
	set_next_step_star_ray_element(_, ColumnIndex, CurrentBoardState, NextStepBoardState):-
			get_square_size(CurrentBoardState, Size),
			ColumnIndex >= Size,
			copy_square(CurrentBoardState, NextStepBoardState),
			!.                 
			                                                                               
	set_next_step_star_ray_element(RowIndex, ColumnIndex, CurrentBoardState, NextStepBoardState):-                                                                                                                                                                                              
			get_square_element(CurrentBoardState, RowIndex, ColumnIndex, CurrentElement),
			CurrentElement < 0,
			copy_square(CurrentBoardState, NextStepBoardState),
			!.   
			                     
	set_next_step_star_ray_element(RowIndex, ColumnIndex, CurrentBoardState, NextStepBoardState):-
			get_square_size(CurrentBoardState, Size),
			RowIndex >= 0,
			RowIndex < Size, 
			ColumnIndex >= 0,
			ColumnIndex < Size, 
			                                                                                           
			get_square_element(CurrentBoardState, RowIndex, ColumnIndex, CurrentElement),
			CurrentElement >= 0,

			set_square_element(CurrentBoardState, RowIndex, ColumnIndex, -3, NextStepBoardState),
			!.
   
% <\Next Step Board Generation *******************************************************************************************************************>

% <Marc Next Step Board ********************************************************************************************************************>
   
   % ������� ������������� ������� ���������� ����
   get_marked_board(square(BoardSize, NextStepBoard), MarkedNextStepBoard):-
		mark_func(NextStepBoard, 0, NextStepBoard, TmpMarkedNextStepBoard),
		copy_square(square(BoardSize, TmpMarkedNextStepBoard), MarkedNextStepBoard),
		!.
 
   % ������ ������ ��� ���� �������, ������� �� ������ RowNumber
   mark_func(E, RowNumber, StartMarkMatrix, NewMarkMatrix):-
   		mark_row(E, RowNumber, 0, StartMarkMatrix, NewMarkMatrix1),	% ����������� ��� �� ������
   		RowNumber1 = RowNumber + 1,					% ����� ��������� ������
   		mark_func(E, RowNumber1, NewMarkMatrix1, ResM),			% �� ������� ������
   		copy_matrix(ResM, NewMarkMatrix),
        !.	
   
   % ��� ������ � ������� �� �������
   mark_func(E, RowNumber, StartMarkMatrix, NewMarkMatrix):-
   		get_matrix_row_count(E, RowCount),				% ������� ����� �����
   		RowNumber >= RowCount,
   		copy_matrix(StartMarkMatrix, NewMarkMatrix),
   		!.
   
   % ������ ������ ��� ����� ������
   mark_row(E, RowNumber, ColNumber, StartMarkMatrix, NewMarkMatrix):-
   		mark_element(E, RowNumber, ColNumber, ResElem),			% ����������� ������
   		set_matrix_element(StartMarkMatrix, RowNumber, ColNumber, ResElem, NewMarkMatrix1),	% ���������� ��������� � ������� 
   		ColNumber1 = ColNumber + 1,					% ��������� ������
   		mark_row(E, RowNumber, ColNumber1, NewMarkMatrix1, NewMarkMatrix),
        !.	% ������� ������		
   
   % ����� �� �������
   mark_row(E, RowNumber, ColNumber, StartMarkMatrix, NewMarkMatrix):-
   		get_matrix_row(E, RowNumber, Row), 				% ����� ������
   		get_list_size(Row,Len),						% ������� ����� ��������
   		ColNumber >= Len,
   		copy_matrix(StartMarkMatrix, NewMarkMatrix),
   		!.
   
   % ������ ������ ������
   mark_element(E, RowNumber, ColNumber, Mark):-
   		get_matrix_row(E, RowNumber, Row), 				% ����� ������
   		get_list_element(Row, ColNumber, Elem),				% ����� ������
   		Elem = -3,							% ���� ����������� ������
   		find_left(E, RowNumber, ColNumber, 0, 0, MarkFriend, MarkEnemy),	% ������� ������
   		Mark1 = 1 + MarkFriend + MarkEnemy,					% ���������
   		find_right(E, RowNumber, ColNumber, 0, 0, MarkFriend1, MarkEnemy1),
   		Mark2 = Mark1 + MarkFriend1 + MarkEnemy1,
		find_up(E, RowNumber, ColNumber, 0, 0, MarkFriend2, MarkEnemy2),
		Mark3 = Mark2 + MarkFriend2 + MarkEnemy2,
		find_down(E, RowNumber, ColNumber, 0, 0, MarkFriend3, MarkEnemy3),
		Mark4 = Mark3 + MarkFriend3 + MarkEnemy3,
		find_left_up(E, RowNumber, ColNumber, 0, 0, MarkFriend4, MarkEnemy4),
		Mark5 = Mark4 + MarkFriend4 + MarkEnemy4,
		find_left_down(E, RowNumber, ColNumber, 0, 0, MarkFriend5, MarkEnemy5),
		Mark6 = Mark5 + MarkFriend5 + MarkEnemy5,
		find_right_up(E, RowNumber, ColNumber, 0, 0, MarkFriend6, MarkEnemy6),
		Mark7 = Mark6 + MarkFriend6 + MarkEnemy6,
		find_right_down(E, RowNumber, ColNumber, 0, 0, MarkFriend7, MarkEnemy7),
		Mark = Mark7 + MarkFriend7 + MarkEnemy7,
        !.

   % ���� �������� ������ � ������		
   mark_element(E, RowNumber, ColNumber, 0):-
   		get_matrix_row(E, RowNumber, Row), 				% ����� ������
   		get_list_element(Row, ColNumber, Elem),				% ����� ������
   		Elem = 0,
        !.							% ���������
   		
   % ���� �������� ��� � ������		
   mark_element(E, RowNumber, ColNumber, -4):-
   		get_matrix_row(E, RowNumber, Row), 				% ����� ������
   		get_list_element(Row, ColNumber, Elem),				% ����� ������
   		Elem = -4,
        !.							% ���������
   
   % ���� ������ ��� ������ ������		
   mark_element(E, RowNumber, ColNumber, -1):-
   		get_matrix_row(E, RowNumber, Row), 				% ����� ������
   		get_list_element(Row, ColNumber, Elem),				% ����� ������
   		Elem = -1,
        !.							% ������ ������
   
   % ���� ������ ��� ������ ������
   mark_element(E, RowNumber, ColNumber, -2):-
   		get_matrix_row(E, RowNumber, Row), 				% ����� ������
   		get_list_element(Row, ColNumber, Elem),				% ����� ������
   		Elem = -2,
        !.							% ������ ������		
   
   % �������� �� ����� ����� � ����		
   is_not_changed(_, StartMarkEnemy, -1):-
   		StartMarkEnemy = 0,
        !.
   
   is_not_changed(StartMarkFriend, _, -2):-
   		StartMarkFriend = 0,
        !.
      
   % ������������ ����� �����
   find_left(E, RowNumber, ColNumber, StartMarkFriend, StartMarkEnemy, NewMarkFriend, NewMarkEnemy):-
   		Col = ColNumber - 1,								% ��������� �����
   		Col >= 0,									% ���� �� ����� �� �������
   		get_matrix_element(E,RowNumber,Col,Elem),					% ������ �������
   		not (Elem = -3),
   		is_not_changed(StartMarkFriend, StartMarkEnemy, Elem),
   		add_mark_for_element(Elem, StartMarkFriend, StartMarkEnemy, AddMarkFriend, AddMarkEnemy),% �������� ���������� ����
   		NewMarkFriend1 = StartMarkFriend + AddMarkFriend,				% ���������
   		NewMarkEnemy1 = StartMarkEnemy + AddMarkEnemy,
   		find_left(E,RowNumber,Col,NewMarkFriend1,NewMarkEnemy1,ResMarkFriend, ResMarkEnemy),% ��������� ������
   		NewMarkFriend = ResMarkFriend,
   		NewMarkEnemy = ResMarkEnemy,
        !.
      
   % ���� �������� ����
   find_left(E, RowNumber, ColNumber, StartMarkFriend, StartMarkEnemy, StartMarkFriend, StartMarkEnemy):-
   		Col = ColNumber - 1,								% ��������� �����
   		Col >= 0,									% ���� �� ����� �� �������
   		get_matrix_element(E,RowNumber,Col,Elem),					% ������ �������
   		not (Elem = -3),
   		not (is_not_changed(StartMarkFriend, StartMarkEnemy, Elem)),
   		!.
   
   % ���� ����� �� �������
   find_left(_, _, ColNumber, StartMarkFriend, StartMarkEnemy, NewMarkFriend, NewMarkEnemy):-
   		Col = ColNumber - 1,								% ��������� �����
   		Col < 0,
   		NewMarkFriend = StartMarkFriend,
   		NewMarkEnemy = StartMarkEnemy,
   		!.
	
   % ���� ����� ��������� ������	
   find_left(E, RowNumber, ColNumber, StartMarkFriend, StartMarkEnemy, StartMarkFriend, StartMarkEnemy):-
   		Col = ColNumber - 1,
   		Col >= 0,									% ���� �� ����� �� �������
   		get_matrix_element(E,RowNumber,Col,Elem),
   		Elem = -3,
   		!.
   
   % ������������ ����� ������
   find_right(E, RowNumber, ColNumber, StartMarkFriend, StartMarkEnemy, NewMarkFriend, NewMarkEnemy):-
   		Col = ColNumber + 1,
   		get_matrix_row(E, RowNumber, Row),
   		get_list_size(Row,Len),
   		Col < Len,
   		get_matrix_element(E, RowNumber, Col, Elem),
   		not (Elem = -3),
   		is_not_changed(StartMarkFriend, StartMarkEnemy, Elem),
   		add_mark_for_element(Elem, StartMarkFriend, StartMarkEnemy, AddMarkFriend, AddMarkEnemy),
   		NewMarkFriend1 = StartMarkFriend + AddMarkFriend,
   		NewMarkEnemy1 = StartMarkEnemy + AddMarkEnemy,
   		find_right(E,RowNumber,Col,NewMarkFriend1,NewMarkEnemy1,ResMarkFriend, ResMarkEnemy),
   		NewMarkFriend = ResMarkFriend,
   		NewMarkEnemy = ResMarkEnemy,
                        !.
      
   find_right(E, RowNumber, ColNumber, StartMarkFriend, StartMarkEnemy, StartMarkFriend, StartMarkEnemy):-
   		Col = ColNumber + 1,
   		get_matrix_row(E, RowNumber, Row),
   		get_list_size(Row,Len),
   		Col < Len,
   		get_matrix_element(E, RowNumber, Col, Elem),
   		not (Elem = -3),
   		not (is_not_changed(StartMarkFriend, StartMarkEnemy, Elem)),
   		!.
   
   find_right(E, RowNumber, ColNumber, StartMarkFriend, StartMarkEnemy, NewMarkFriend, NewMarkEnemy):-
   		Col = ColNumber + 1,
   		get_matrix_row(E, RowNumber, Row),
   		get_list_size(Row,Len),
   		Col >= Len,
   		NewMarkFriend = StartMarkFriend,
   		NewMarkEnemy = StartMarkEnemy,
   		!.
   		
   find_right(E, RowNumber, ColNumber, StartMarkFriend, StartMarkEnemy, StartMarkFriend, StartMarkEnemy):-
   		Col = ColNumber + 1,
   		get_matrix_row(E, RowNumber, Row),
   		get_list_size(Row,Len),
   		Col < Len,
   		get_matrix_element(E, RowNumber, Col, Elem),
   		Elem = -3,
   		!.     
   
   % ������������ ����� ������		
   find_up(E, RowNumber, ColNumber, StartMarkFriend, StartMarkEnemy, NewMarkFriend, NewMarkEnemy):-
   		Row = RowNumber - 1,
   		Row >= 0,
   		get_matrix_element(E,Row,ColNumber,Elem),
   		not (Elem = -3),
   		is_not_changed(StartMarkFriend, StartMarkEnemy, Elem),
   		add_mark_for_element(Elem, StartMarkFriend, StartMarkEnemy, AddMarkFriend, AddMarkEnemy),
   		NewMarkFriend1 = StartMarkFriend + AddMarkFriend,
   		NewMarkEnemy1 = StartMarkEnemy + AddMarkEnemy,
   		find_up(E,Row,ColNumber,NewMarkFriend1,NewMarkEnemy1,ResMarkFriend, ResMarkEnemy),
   		NewMarkFriend = ResMarkFriend,
   		NewMarkEnemy = ResMarkEnemy,
                        !.
   
   find_up(E, RowNumber, ColNumber, StartMarkFriend, StartMarkEnemy, StartMarkFriend, StartMarkEnemy):-
   		Row = RowNumber - 1,
   		Row >= 0,
   		get_matrix_element(E,Row,ColNumber,Elem),
   		not (Elem = -3),
   		not (is_not_changed(StartMarkFriend, StartMarkEnemy, Elem)),
   		!.
   
   find_up(_, RowNumber, _, StartMarkFriend, StartMarkEnemy, NewMarkFriend, NewMarkEnemy):-
   		Row = RowNumber - 1,
   		Row < 0,
   		NewMarkFriend = StartMarkFriend,
   		NewMarkEnemy = StartMarkEnemy,
   		!.
   		
   find_up(E, RowNumber, ColNumber, StartMarkFriend, StartMarkEnemy, StartMarkFriend, StartMarkEnemy):-
   		Row = RowNumber - 1,
   		Row >= 0,
   		get_matrix_element(E,Row,ColNumber,Elem),
   		Elem = -3,
   		!.   
   
   % ������������ ����� �����		
   find_down(E, RowNumber, ColNumber, StartMarkFriend, StartMarkEnemy, NewMarkFriend, NewMarkEnemy):-
   		Row = RowNumber + 1,
   		get_matrix_row_count(E,RowCount),
   		Row < RowCount,
   		get_matrix_element(E,Row,ColNumber,Elem),
   		not (Elem = -3),
   		is_not_changed(StartMarkFriend, StartMarkEnemy, Elem),
   		add_mark_for_element(Elem, StartMarkFriend, StartMarkEnemy, AddMarkFriend, AddMarkEnemy),
   		NewMarkFriend1 = StartMarkFriend + AddMarkFriend,
   		NewMarkEnemy1 = StartMarkEnemy + AddMarkEnemy,
   		find_down(E,Row,ColNumber,NewMarkFriend1,NewMarkEnemy1,ResMarkFriend, ResMarkEnemy),
   		NewMarkFriend = ResMarkFriend,
   		NewMarkEnemy = ResMarkEnemy,
                        !.
   
   find_down(E, RowNumber, ColNumber, StartMarkFriend, StartMarkEnemy, StartMarkFriend, StartMarkEnemy):-
   		Row = RowNumber + 1,
   		get_matrix_row_count(E,RowCount),
   		Row < RowCount,
   		get_matrix_element(E,Row,ColNumber,Elem),
   		not (Elem = -3),
   		not (is_not_changed(StartMarkFriend, StartMarkEnemy, Elem)),
   		!.
   
   find_down(E, RowNumber, _, StartMarkFriend, StartMarkEnemy, NewMarkFriend, NewMarkEnemy):-
   		Row = RowNumber + 1,
   		get_matrix_row_count(E,RowCount),
   		Row >= RowCount,
   		NewMarkFriend = StartMarkFriend,
   		NewMarkEnemy = StartMarkEnemy,
   		!.
   
   find_down(E, RowNumber, ColNumber, StartMarkFriend, StartMarkEnemy, StartMarkFriend, StartMarkEnemy):-
   		Row = RowNumber + 1,
   		get_matrix_row_count(E,RowCount),
   		Row < RowCount,
   		get_matrix_element(E,Row,ColNumber,Elem),
   		Elem = -3,
   		!.
   
   % ������������ ����� �����-������		
   find_left_up(E, RowNumber, ColNumber, StartMarkFriend, StartMarkEnemy, NewMarkFriend, NewMarkEnemy):-
   		RowNumber2 = RowNumber - 1,
   		RowNumber2 >= 0,
   		ColNumber2 = ColNumber - 1,
   		ColNumber2 >= 0,
   		get_matrix_element(E,RowNumber2,ColNumber2,Elem),
   		not (Elem = -3),
   		is_not_changed(StartMarkFriend, StartMarkEnemy, Elem),
   		add_mark_for_element(Elem, StartMarkFriend, StartMarkEnemy, AddMarkFriend, AddMarkEnemy),
   		NewMarkFriend1 = StartMarkFriend + AddMarkFriend,
   		NewMarkEnemy1 = StartMarkEnemy + AddMarkEnemy,
   		find_left_up(E,RowNumber2,ColNumber2,NewMarkFriend1,NewMarkEnemy1,ResMarkFriend, ResMarkEnemy),
   		NewMarkFriend = ResMarkFriend,
   		NewMarkEnemy = ResMarkEnemy,
                        !.
   
   find_left_up(E, RowNumber, ColNumber, StartMarkFriend, StartMarkEnemy, StartMarkFriend, StartMarkEnemy):-
   		RowNumber2 = RowNumber - 1,
   		RowNumber2 >= 0,
   		ColNumber2 = ColNumber - 1,
   		ColNumber2 >= 0,
   		get_matrix_element(E,RowNumber2,ColNumber2,Elem),
   		not (Elem = -3),
   		not (is_not_changed(StartMarkFriend, StartMarkEnemy, Elem)),
   		!.
   
   find_left_up(_, _, ColNumber, StartMarkFriend, StartMarkEnemy, NewMarkFriend, NewMarkEnemy):-
   		ColNumber2 = ColNumber - 1,
   		ColNumber2 < 0,
   		NewMarkFriend = StartMarkFriend,
   		NewMarkEnemy = StartMarkEnemy,
   		!.
   		
   find_left_up(E, RowNumber, ColNumber, StartMarkFriend, StartMarkEnemy, StartMarkFriend, StartMarkEnemy):-
   		RowNumber2 = RowNumber - 1,
   		RowNumber2 >= 0,
   		ColNumber2 = ColNumber - 1,
   		ColNumber2 >= 0,
   		get_matrix_element(E,RowNumber2,ColNumber2,Elem),
   		Elem = -3,
   		!.	
   		
   find_left_up(_, RowNumber, _, StartMarkFriend, StartMarkEnemy, NewMarkFriend, NewMarkEnemy):-
   		RowNumber2 = RowNumber - 1,
   		RowNumber2 < 0,
   		NewMarkFriend = StartMarkFriend,
   		NewMarkEnemy = StartMarkEnemy,
   		!.
   
   % ������������ ����� ������-������
   find_right_up(E, RowNumber, ColNumber, StartMarkFriend, StartMarkEnemy, NewMarkFriend, NewMarkEnemy):-
   		RowNumber2 = RowNumber - 1,
   		RowNumber2 >= 0,
   		ColNumber2 = ColNumber + 1,
   		get_matrix_row(E,RowNumber2,Row),
   		get_list_size(Row,Len),
   		ColNumber2 < Len,
   		get_matrix_element(E,RowNumber2,ColNumber2,Elem),
   		not (Elem = -3),
   		is_not_changed(StartMarkFriend, StartMarkEnemy, Elem),
   		add_mark_for_element(Elem, StartMarkFriend, StartMarkEnemy, AddMarkFriend, AddMarkEnemy),
   		NewMarkFriend1 = StartMarkFriend + AddMarkFriend,
   		NewMarkEnemy1 = StartMarkEnemy + AddMarkEnemy,
   		find_right_up(E, RowNumber2, ColNumber2, NewMarkFriend1, NewMarkEnemy1, ResMarkFriend, ResMarkEnemy),
   		NewMarkFriend = ResMarkFriend,
   		NewMarkEnemy = ResMarkEnemy,
                        !.
   
   find_right_up(E, RowNumber, ColNumber, StartMarkFriend, StartMarkEnemy, StartMarkFriend, StartMarkEnemy):-
   		RowNumber2 = RowNumber - 1,
   		RowNumber2 >= 0,
   		ColNumber2 = ColNumber + 1,
   		get_matrix_row(E,RowNumber2,Row),
   		get_list_size(Row,Len),
   		ColNumber2 < Len,
   		get_matrix_element(E,RowNumber2,ColNumber2,Elem),
   		not (Elem = -3),
   		not (is_not_changed(StartMarkFriend, StartMarkEnemy, Elem)),
   		!.
   
   find_right_up(_, RowNumber, _, StartMarkFriend, StartMarkEnemy, NewMarkFriend, NewMarkEnemy):-
   		RowNumber2 = RowNumber - 1,
   		RowNumber2 < 0,
   		NewMarkFriend = StartMarkFriend,
   		NewMarkEnemy = StartMarkEnemy,
   		!.
   		
   find_right_up(E, RowNumber, ColNumber, StartMarkFriend, StartMarkEnemy, StartMarkFriend, StartMarkEnemy):-
   		RowNumber2 = RowNumber - 1,
   		RowNumber2 >= 0,
   		ColNumber2 = ColNumber + 1,
   		get_matrix_row(E,RowNumber2,Row),
   		get_list_size(Row,Len),
   		ColNumber2 < Len,
   		get_matrix_element(E,RowNumber2,ColNumber2,Elem),
   		Elem = -3,
   		!.
   
   find_right_up(E, RowNumber, ColNumber, StartMarkFriend, StartMarkEnemy, NewMarkFriend, NewMarkEnemy):-
   		RowNumber2 = RowNumber - 1,
   		ColNumber2 = ColNumber + 1,
   		get_matrix_row(E,RowNumber2,Row),
   		get_list_size(Row,Len),
   		ColNumber2 >= Len,
   		NewMarkFriend = StartMarkFriend,
   		NewMarkEnemy = StartMarkEnemy,
   		!.
   
   % ������������ ����� ������-�����		
   find_right_down(E, RowNumber, ColNumber, StartMarkFriend, StartMarkEnemy, NewMarkFriend, NewMarkEnemy):- 
   		RowNumber2 = RowNumber + 1,
   		get_matrix_row_count(E,RowCount),
   		RowNumber2 < RowCount,
   		ColNumber2 = ColNumber + 1,
   		get_matrix_row(E,RowNumber2,Row),
   		get_list_size(Row,Len),
   		ColNumber2 < Len,
   		get_matrix_element(E,RowNumber2,ColNumber2,Elem),
   		not (Elem = -3),
   		is_not_changed(StartMarkFriend, StartMarkEnemy, Elem),
   		add_mark_for_element(Elem, StartMarkFriend, StartMarkEnemy, AddMarkFriend, AddMarkEnemy),
   		NewMarkFriend1 = StartMarkFriend + AddMarkFriend,
   		NewMarkEnemy1 = StartMarkEnemy + AddMarkEnemy,
   		find_right_down(E,RowNumber2,ColNumber2,NewMarkFriend1,NewMarkEnemy1,ResMarkFriend, ResMarkEnemy),
   		NewMarkFriend = ResMarkFriend,
   		NewMarkEnemy = ResMarkEnemy,
        !.
   
   find_right_down(E, RowNumber, ColNumber, StartMarkFriend, StartMarkEnemy, StartMarkFriend, StartMarkEnemy):-
   		RowNumber2 = RowNumber + 1,
   		get_matrix_row_count(E,RowCount),
   		RowNumber2 < RowCount,
   		ColNumber2 = ColNumber + 1,
   		get_matrix_row(E,RowNumber2,Row),
   		get_list_size(Row,Len),
   		ColNumber2 < Len,
   		get_matrix_element(E,RowNumber2,ColNumber2,Elem),
   		not (Elem = -3),
   		not (is_not_changed(StartMarkFriend, StartMarkEnemy, Elem)),
   		!.
   
   find_right_down(E, RowNumber, _, StartMarkFriend, StartMarkEnemy, NewMarkFriend, NewMarkEnemy):-
   		RowNumber2 = RowNumber + 1,
   		get_matrix_row_count(E,RowCount),
   		RowNumber2 >= RowCount,
   		NewMarkFriend = StartMarkFriend,
   		NewMarkEnemy = StartMarkEnemy,
   		!.
   		
   find_right_down(E, RowNumber, ColNumber, StartMarkFriend, StartMarkEnemy, NewMarkFriend, NewMarkEnemy):-
   		ColNumber2 = ColNumber + 1,
   		get_matrix_row(E,RowNumber,Row),
   		get_list_size(Row,Len),
   		ColNumber2 >= Len,
   		NewMarkFriend = StartMarkFriend,
   		NewMarkEnemy = StartMarkEnemy,
   		!.
   
   find_right_down(E, RowNumber, ColNumber, StartMarkFriend, StartMarkEnemy, StartMarkFriend, StartMarkEnemy):-
   		RowNumber2 = RowNumber + 1,
   		get_matrix_row_count(E,RowCount),
   		RowNumber2 < RowCount,
   		ColNumber2 = ColNumber + 1,
   		get_matrix_row(E,RowNumber2,Row),
   		get_list_size(Row,Len),
   		ColNumber2 < Len,
   		get_matrix_element(E,RowNumber2,ColNumber2,Elem),
   		Elem = -3,
   		!.  
   
   % ������������ ����� ��e��-�����		
   find_left_down(E, RowNumber, ColNumber, StartMarkFriend, StartMarkEnemy, NewMarkFriend, NewMarkEnemy):-
   		RowNumber2 = RowNumber + 1,
   		get_matrix_row_count(E,RowCount),
   		RowNumber2 < RowCount,
   		ColNumber2 = ColNumber - 1,
   		ColNumber2 >= 0,
   		get_matrix_element(E,RowNumber2,ColNumber2,Elem),
   		not (Elem = -3),
   		is_not_changed(StartMarkFriend, StartMarkEnemy, Elem),
   		add_mark_for_element(Elem, StartMarkFriend, StartMarkEnemy, AddMarkFriend, AddMarkEnemy),
   		NewMarkFriend1 = StartMarkFriend + AddMarkFriend,
   		NewMarkEnemy1 = StartMarkEnemy + AddMarkEnemy,
   		find_left_down(E,RowNumber2,ColNumber2,NewMarkFriend1,NewMarkEnemy1,ResMarkFriend, ResMarkEnemy),
   		NewMarkFriend = ResMarkFriend,
   		NewMarkEnemy = ResMarkEnemy.
   
   find_left_down(E, RowNumber, ColNumber, StartMarkFriend, StartMarkEnemy, StartMarkFriend, StartMarkEnemy):-
   		RowNumber2 = RowNumber + 1,
   		get_matrix_row_count(E,RowCount),
   		RowNumber2 < RowCount,
   		ColNumber2 = ColNumber - 1,
   		ColNumber2 >= 0,
   		get_matrix_element(E,RowNumber2,ColNumber2,Elem),
   		not (Elem = -3),
   		not (is_not_changed(StartMarkFriend, StartMarkEnemy, Elem)),
   		!.
   
   find_left_down(E, RowNumber, _, StartMarkFriend, StartMarkEnemy, NewMarkFriend, NewMarkEnemy):-
   		RowNumber2 = RowNumber + 1,
   		get_matrix_row_count(E,RowCount),
   		RowNumber2 >= RowCount,
   		NewMarkFriend = StartMarkFriend,
   		NewMarkEnemy = StartMarkEnemy,
   		!.   	
   		
   find_left_down(_, _, ColNumber, StartMarkFriend, StartMarkEnemy, NewMarkFriend, NewMarkEnemy):-
   		ColNumber2 = ColNumber - 1,
   		ColNumber2 < 0,
   		NewMarkFriend = StartMarkFriend,
   		NewMarkEnemy = StartMarkEnemy,
   		!.   			
   
   find_left_down(E, RowNumber, ColNumber, StartMarkFriend, StartMarkEnemy, StartMarkFriend, StartMarkEnemy):-
   		RowNumber2 = RowNumber + 1,
   		get_matrix_row_count(E,RowCount),
   		RowNumber2 < RowCount,
   		ColNumber2 = ColNumber - 1,
   		ColNumber2 >= 0,
   		get_matrix_element(E,RowNumber2,ColNumber2,Elem),
   		Elem = -3,
   		!.
   
   % ������� ������
   
   % ����� �������� ������		
   add_mark_for_element(0, _, _, AddMarkFriend,AddMarkEnemy):-
   		AddMarkFriend = 0,					% ������ � �� ���������
   		AddMarkEnemy = 0,
   		!.
   
   % ���� ������ ������ ������		
   add_mark_for_element(-3, _, _, AddMarkFriend,AddMarkEnemy):-
   		AddMarkFriend = 0,					% ������ � �� ���������
   		AddMarkEnemy = 0,
   		!.
   
   % ����� ���� ���� �����		
   add_mark_for_element(-1, 0, MarkEnemy, AddMarkFriend, AddMarkEnemy):-
   		MarkEnemy <= 0,						% ���� �� ���� �� ����� ��������� � �����
   		AddMarkFriend = 1,				
   		AddMarkEnemy = 0,
        !.
   
   % ��� ������
   add_mark_for_element(-1, 1, MarkEnemy, 2, 0):-
   		MarkEnemy <= 0,						% ���� �� ���� �� ����� ��������� � �����
        !.
   
   % ��� � ���                     
   add_mark_for_element(-1, 3, MarkEnemy, 3, 0):-
   		MarkEnemy <= 0,						% ���� �� ���� �� ����� ��������� � �����
        !.
                        
   % ������ � ���
   add_mark_for_element(-1, 6, MarkEnemy, 7, 0):-
   		MarkEnemy <= 0,						% ���� �� ���� �� ����� ��������� � �����
        !.
                        
   add_mark_for_element(-1, MarkFriend, MarkEnemy, 1, 0):- 
   		MarkEnemy <= 0,					
   		MarkFriend > 13,				
        !.
   
   % ����� � ����� 1		
   add_mark_for_element(-2, MarkFriend, 0, AddMarkFriend, AddMarkEnemy):-
   		MarkFriend <= 0,					% ���� �� ���� ����� � ����� � ��� ���� ��� ���� ��� ���������, �� ��� ���
   		AddMarkEnemy = 1,					
   		AddMarkFriend = 0,
        !.
   
   % ����� � ����� ��������� �� 2		
   add_mark_for_element(-2, MarkFriend, 1, AddMarkFriend, AddMarkEnemy):-
   		MarkFriend <= 0,					% ���� �� ���� ����� � ����� � ��� ���� ��� ���� ��� ���������, �� ��� ���
   		AddMarkEnemy = 2,					
   		AddMarkFriend = 0,
        !.
                       
   % ����� � ����� ��������� �� 3		
   add_mark_for_element(-2, MarkFriend, 3, AddMarkFriend, AddMarkEnemy):-
   		MarkFriend <= 0,					% ���� �� ���� ����� � ����� � ��� ���� ��� ���� ��� ���������, �� ��� ���
   		AddMarkEnemy = 4,				
   		AddMarkFriend = 0,
        !.
    
   % ����� � ����� ��������� �� 4		
   add_mark_for_element(-2, MarkFriend, 7, AddMarkFriend, AddMarkEnemy):-
   		MarkFriend <= 0,					% ���� �� ���� ����� � ����� � ��� ���� ��� ���� ��� ���������, �� ��� ���
   		AddMarkEnemy = 5,					
   		AddMarkFriend = 0,
        !.
    
   
   add_mark_for_element(-2, MarkFriend, MarkEnemy, 0, 1):- 
   		MarkFriend <= 0,					% ���� �� ���� �� ����� � ����� �����
   		MarkEnemy > 12,						% � ��� ���� �� ������� ��� ��� ��������� � �����
        !.									                          
            
                        
   add_mark_for_element(_, _, _, 0, 0):-
   		!.					
   

% <\Marc Next Step Board ********************************************************************************************************************>  

% <Arbitrator ************************************************************************************************************************************>

   % ��������� ��������� ���� �� ����
   get_checked_next_step_board(square(BoardSize, NextStepBoardState), CheckedNextStepBoardState):-
		check_func(NextStepBoardState, 0, NextStepBoardState, TmpCheckedNextStepBoard),
		copy_square(square(BoardSize, TmpCheckedNextStepBoard), CheckedNextStepBoardState),
		!.
 
   % ��� ������ � ������� �� �������
   check_func(E, RowNumber, StartMatrix, NewMatrix):-
   		get_matrix_row_count(E, RowCount),			
   		RowNumber >= RowCount,
   		copy_matrix(StartMatrix, NewMatrix),
   		!.
 
   % ������ ����� ��� ���� �������, ������� �� ������ RowNumber
   check_func(E, RowNumber, StartMatrix, NewMatrix):-
   		check_row(E, RowNumber, 0, StartMatrix, NewMatrix1),
   		RowNumber1 = RowNumber + 1,					
   		check_func(E, RowNumber1, NewMatrix1, ResM),			
   		copy_matrix(ResM, NewMatrix),
        !.	
   
   % ����� �� �������
   check_row(E, RowNumber, ColNumber, StartMatrix, NewMatrix):-
   		get_matrix_row(E, RowNumber, Row), 				
   		get_list_size(Row,Len),						
   		ColNumber >= Len,
   		copy_matrix(StartMatrix, NewMatrix),
   		!.
   
   % ������ ����� ��� ����� ������
   check_row(E, RowNumber, ColNumber, StartMatrix, NewMatrix):-
   		check_element(E, RowNumber, ColNumber, ResElem),			
   		set_matrix_element(StartMatrix, RowNumber, ColNumber, ResElem, NewMatrix1),	
   		ColNumber1 = ColNumber + 1,					
   		check_row(E, RowNumber, ColNumber1, NewMatrix1, NewMatrix),
        !.		
   
   
   % ��������� ��� ����������� � �����������
   check_element(E, RowNumber, ColNumber, CheckState):-
   		get_matrix_row(E, RowNumber, Row), 				
   		get_list_element(Row, ColNumber, Elem),
   		Elem <> -3,
   		CheckState = Elem,
   		!.
   
   % ����� 3�3
   check_element(E, RowNumber, ColNumber, CheckState):-
   		get_matrix_row(E, RowNumber, Row), 				
   		get_list_element(Row, ColNumber, Elem),				
   		Elem = -3,							
   		find_left(E, RowNumber, ColNumber, 0, 0, CheckFriend1, _),
   		CheckFriend1 = 1,				
   		find_right(E, RowNumber, ColNumber, 0, 0, CheckFriend2, _),
   		CheckFriend2 = 1,
		find_up(E, RowNumber, ColNumber, 0, 0, CheckFriend3, _),
   		CheckFriend3 = 1,
		find_down(E, RowNumber, ColNumber, 0, 0, CheckFriend4, _),
   		CheckFriend4 = 1,
   		CheckState = -4,
   		!.
   
   % ���� ����� �� 3�3, � ��� ���� ��� ����������� 4�4
   check_element(E, RowNumber, ColNumber, CheckState):-
   		get_matrix_row(E, RowNumber, Row), 				
   		get_list_element(Row, ColNumber, Elem),			
   		Elem = -3,							
   		find_left(E, RowNumber, ColNumber, 0, 0, CheckFriend1, _),
   		CheckFriend1 <> 1,
   		CheckFriend1 <> 3,			
   		CheckState = Elem,
   		!. 
   
   % ����� 4�4 ������ � ������		
   check_element(E, RowNumber, ColNumber, CheckState):-
   		get_matrix_row(E, RowNumber, Row), 				
   		get_list_element(Row, ColNumber, Elem),				
   		Elem = -3,											
   		find_right(E, RowNumber, ColNumber, 0, 0, CheckFriend2, _),
   		CheckFriend2 = 3,
		find_up(E, RowNumber, ColNumber, 0, 0, CheckFriend3, _),
   		CheckFriend3 = 3,
   		CheckState = -4,
   		!.
   
   % ����� �� 4�4 (��� ������, �� � ��� �����)		
   check_element(E, RowNumber, ColNumber, CheckState):-
   		get_matrix_row(E, RowNumber, Row), 				
   		get_list_element(Row, ColNumber, Elem),				
   		Elem = -3,											
   		find_right(E, RowNumber, ColNumber, 0, 0, CheckFriend2, _),
   		CheckFriend2 <> 3,
   		CheckFriend2 <> 1,
		find_left(E, RowNumber, ColNumber, 0, 0, CheckFriend1, _),
   		CheckFriend1 <> 3,
   		CheckState = Elem,
   		!.
   		
   % �� 4�4 (��� ������, �� � ��� �����)		
   check_element(E, RowNumber, ColNumber, CheckState):-
   		get_matrix_row(E, RowNumber, Row), 				
   		get_list_element(Row, ColNumber, Elem),				
   		Elem = -3,											
   		find_up(E, RowNumber, ColNumber, 0, 0, CheckFriend2, _),
   		CheckFriend2 <> 3,
   		CheckFriend2 <> 1,
		find_down(E, RowNumber, ColNumber, 0, 0, CheckFriend1, _),
   		CheckFriend1 <> 3,
   		CheckState = Elem,
   		!.
   		
   % �� 4�4 (��� ������, ��� �����, �� � ��� ������)		
   check_element(E, RowNumber, ColNumber, CheckState):-
   		get_matrix_row(E, RowNumber, Row), 				
   		get_list_element(Row, ColNumber, Elem),				
   		Elem = -3,											
   		find_up(E, RowNumber, ColNumber, 0, 0, CheckFriend2, _),
   		CheckFriend2 = 3,
		find_left(E, RowNumber, ColNumber, 0, 0, CheckFriend1, _),
   		CheckFriend1 <> 3,
   		CheckFriend2 <> 1,
   		find_right(E, RowNumber, ColNumber, 0, 0, CheckFriend3, _),
   		CheckFriend3 <> 3,
   		CheckState = Elem,
   		!.
   		
   % �� 4�4 (��� �����, ��� �����, �� � ��� ������)	 	
   check_element(E, RowNumber, ColNumber, CheckState):-
   		get_matrix_row(E, RowNumber, Row), 				
   		get_list_element(Row, ColNumber, Elem),				
   		Elem = -3,											
   		find_down(E, RowNumber, ColNumber, 0, 0, CheckFriend2, _),
   		CheckFriend2 = 3,
		find_left(E, RowNumber, ColNumber, 0, 0, CheckFriend1, _),
   		CheckFriend1 <> 3,
   		CheckFriend2 <> 1,
   		find_right(E, RowNumber, ColNumber, 0, 0, CheckFriend3, _),
   		CheckFriend3 <> 3,
   		CheckState = Elem,
   		!.
   		
   % �� 4�4 (��� �����, ��� ������, �� � ��� �����)		
   check_element(E, RowNumber, ColNumber, CheckState):-
   		get_matrix_row(E, RowNumber, Row), 				
   		get_list_element(Row, ColNumber, Elem),				
   		Elem = -3,											
   		find_left(E, RowNumber, ColNumber, 0, 0, CheckFriend2, _),
   		CheckFriend2 = 3,
		find_up(E, RowNumber, ColNumber, 0, 0, CheckFriend1, _),
   		CheckFriend1 <> 3,
   		CheckFriend2 <> 1,
   		find_down(E, RowNumber, ColNumber, 0, 0, CheckFriend3, _),
   		CheckFriend3 <> 3,
   		CheckState = Elem,
   		!.
   		
   % �� 4�4 (��� ������, ��� ������, �� � ��� �����)		
   check_element(E, RowNumber, ColNumber, CheckState):-
   		get_matrix_row(E, RowNumber, Row), 				
   		get_list_element(Row, ColNumber, Elem),				
   		Elem = -3,											
   		find_right(E, RowNumber, ColNumber, 0, 0, CheckFriend2, _),
   		CheckFriend2 = 3,
		find_up(E, RowNumber, ColNumber, 0, 0, CheckFriend1, _),
   		CheckFriend1 <> 3,
   		CheckFriend2 <> 1,
   		find_down(E, RowNumber, ColNumber, 0, 0, CheckFriend3, _),
   		CheckFriend3 <> 3,
   		CheckState = Elem,
   		!.
   		
   % 4�4 (����� ������)		
   check_element(E, RowNumber, ColNumber, CheckState):-
   		get_matrix_row(E, RowNumber, Row), 				
   		get_list_element(Row, ColNumber, Elem),				
   		Elem = -3,							
   		find_left(E, RowNumber, ColNumber, 0, 0, CheckFriend1, _),
   		CheckFriend1 = 3,				
		find_up(E, RowNumber, ColNumber, 0, 0, CheckFriend3, _),
   		CheckFriend3 = 3,
   		CheckState = -4,
   		!.
   		
   % 4�4 (����� ����)		
   check_element(E, RowNumber, ColNumber, CheckState):-
   		get_matrix_row(E, RowNumber, Row), 				
   		get_list_element(Row, ColNumber, Elem),				
   		Elem = -3,							
   		find_left(E, RowNumber, ColNumber, 0, 0, CheckFriend1, _),
   		CheckFriend1 = 3,				
		find_down(E, RowNumber, ColNumber, 0, 0, CheckFriend4, _),
   		CheckFriend4 = 3,
   		CheckState = -4,
   		!.
   		
   % 4�4 (������ ����)		
   check_element(E, RowNumber, ColNumber, CheckState):-
   		get_matrix_row(E, RowNumber, Row), 				
   		get_list_element(Row, ColNumber, Elem),				
   		Elem = -3,											
   		find_right(E, RowNumber, ColNumber, 0, 0, CheckFriend2, _),
   		CheckFriend2 = 3,
		find_down(E, RowNumber, ColNumber, 0, 0, CheckFriend4, _),
   		CheckFriend4 = 3,
   		CheckState = -4,
   		!.
   		
   check_element(E, RowNumber, ColNumber, CheckState):-
   		get_matrix_row(E, RowNumber, Row), 				
   		get_list_element(Row, ColNumber, Elem),
   		CheckState = Elem,
   		!.
   
   % �������� ��������� ����      	
   test_func(CurrentBoardStateMatrix,StartRow,Result):-
		get_matrix_row_count(CurrentBoardStateMatrix,RowCount),
		StartRow < RowCount,
		test_row(CurrentBoardStateMatrix,StartRow,0,Result2),
		Result2 = 0,
		NextRowNumber = StartRow + 1,
		test_func(CurrentBoardStateMatrix,NextRowNumber,Result),
		!.
   	
   test_func(CurrentBoardStateMatrix,StartRow,Result):-
		get_matrix_row_count(CurrentBoardStateMatrix,RowCount),
		StartRow >= RowCount,
		Result = 0,
		!.
   	
   test_func(CurrentBoardStateMatrix,StartRow,Result):-
		get_matrix_row_count(CurrentBoardStateMatrix,RowCount),
		StartRow < RowCount,
		test_row(CurrentBoardStateMatrix,StartRow,0,Result),
		Result <> 0,
		!.
   	
   test_row(CurrentBoardStateMatrix,RowNumber,ColNumber,Result):-
		get_matrix_row(CurrentBoardStateMatrix,RowNumber,Row),
		get_list_size(Row,ColCount),
		ColNumber < ColCount,
		test_element(CurrentBoardStateMatrix,RowNumber,ColNumber,Result2),
		Result2 = 0,
		ColNumber2 = ColNumber + 1,
		test_row(CurrentBoardStateMatrix,RowNumber,ColNumber2,Result),
		!.
   	
   test_row(CurrentBoardStateMatrix,RowNumber,ColNumber,Result):-
		get_matrix_row(CurrentBoardStateMatrix,RowNumber,Row),
		get_list_size(Row,ColCount),
		ColNumber >= ColCount,
		Result = 0,
		!.
   	
   test_row(CurrentBoardStateMatrix,RowNumber,ColNumber,Result):-
		get_matrix_row(CurrentBoardStateMatrix,RowNumber,Row),
		get_list_size(Row,ColCount),
		ColNumber < ColCount,
		test_element(CurrentBoardStateMatrix,RowNumber,ColNumber,Result),
		Result <> 0,
		!.
   	
   test_element(CurrentBoardStateMatrix,RowNumber,ColNumber,Result):-
		get_matrix_element(CurrentBoardStateMatrix,RowNumber,ColNumber,Elem),
		Elem = -1,
		find_win(-1,CurrentBoardStateMatrix,RowNumber,ColNumber,Win),
		Result = Win,
		!.
   
   test_element(CurrentBoardStateMatrix,RowNumber,ColNumber,Result):-
		get_matrix_element(CurrentBoardStateMatrix,RowNumber,ColNumber,Elem),
		Elem = -2,
		find_win(-2,CurrentBoardStateMatrix,RowNumber,ColNumber,Win),
		Result = Win,
		!.
   	
   test_element(CurrentBoardStateMatrix,RowNumber,ColNumber,Result):-
		get_matrix_element(CurrentBoardStateMatrix,RowNumber,ColNumber,Elem),
		Elem <= -3,
		Result = 0,
		!.
   	
   test_element(CurrentBoardStateMatrix,RowNumber,ColNumber,Result):-
		get_matrix_element(CurrentBoardStateMatrix,RowNumber,ColNumber,Elem),
		Elem >= 0,
		Result = 0,
		!.
   
   find_win(Type,CurrentBoardStateMatrix,RowNumber,ColNumber,Win):-
		find_win_l(Type,CurrentBoardStateMatrix,RowNumber,ColNumber,Win),
		!.
   
   find_win(Type,CurrentBoardStateMatrix,RowNumber,ColNumber,Win):-
		find_win_r(Type,CurrentBoardStateMatrix,RowNumber,ColNumber,Win),
		!.
   	
   find_win(Type,CurrentBoardStateMatrix,RowNumber,ColNumber,Win):-
		find_win_u(Type,CurrentBoardStateMatrix,RowNumber,ColNumber,Win),
		!.
   	
   find_win(Type,CurrentBoardStateMatrix,RowNumber,ColNumber,Win):-
		find_win_d(Type,CurrentBoardStateMatrix,RowNumber,ColNumber,Win),
		!.
   	
   find_win(Type,CurrentBoardStateMatrix,RowNumber,ColNumber,Win):-
   		find_win_lu(Type,CurrentBoardStateMatrix,RowNumber,ColNumber,Win),
   		!.
   	
   find_win(Type,CurrentBoardStateMatrix,RowNumber,ColNumber,Win):-
   		find_win_ld(Type,CurrentBoardStateMatrix,RowNumber,ColNumber,Win),
   		!.
   	
   find_win(Type,CurrentBoardStateMatrix,RowNumber,ColNumber,Win):-
   		find_win_ru(Type,CurrentBoardStateMatrix,RowNumber,ColNumber,Win),
   		!.
   	
   find_win(Type,CurrentBoardStateMatrix,RowNumber,ColNumber,Win):-
   		find_win_rd(Type,CurrentBoardStateMatrix,RowNumber,ColNumber,Win),
   		!.	
   	
   find_win(_,_,_,_,Win):-
   		Win = 0,
   		!.
   
   find_win_l(-1,CurrentBoardStateMatrix,RowNumber,ColNumber,-1):-
   		find_left(CurrentBoardStateMatrix,RowNumber,ColNumber,0,0,Friend,_),
   		Friend >= 13,
   		!.
   
   find_win_l(-2,CurrentBoardStateMatrix,RowNumber,ColNumber,-2):-
   		find_left(CurrentBoardStateMatrix,RowNumber,ColNumber,0,0,_,Enemy),
   		Enemy >= 12,
   		!.
   	   	
   find_win_r(-1,CurrentBoardStateMatrix,RowNumber,ColNumber,-1):-
   		find_right(CurrentBoardStateMatrix,RowNumber,ColNumber,0,0,Friend,_),
   		Friend >= 13,
   		!.
   
   find_win_r(-2,CurrentBoardStateMatrix,RowNumber,ColNumber,-2):-
   		find_right(CurrentBoardStateMatrix,RowNumber,ColNumber,0,0,_,Enemy),
   		Enemy >= 12,
   		!.
   
   find_win_u(-1,CurrentBoardStateMatrix,RowNumber,ColNumber,-1):-
   		find_up(CurrentBoardStateMatrix,RowNumber,ColNumber,0,0,Friend,_),
   		Friend >= 13,
   		!.
   	
   find_win_u(-2,CurrentBoardStateMatrix,RowNumber,ColNumber,-2):-
   		find_up(CurrentBoardStateMatrix,RowNumber,ColNumber,0,0,_,Enemy),
   		Enemy >= 12,
   		!.	
   	
   find_win_d(-1,CurrentBoardStateMatrix,RowNumber,ColNumber,-1):-
   		find_down(CurrentBoardStateMatrix,RowNumber,ColNumber,0,0,Friend,_),
   		Friend >= 13,
   		!.
  
   find_win_d(-2,CurrentBoardStateMatrix,RowNumber,ColNumber,-2):-
   		find_down(CurrentBoardStateMatrix,RowNumber,ColNumber,0,0,_,Enemy),
   		Enemy >= 12,
   		!.	
   
   find_win_lu(-1,CurrentBoardStateMatrix,RowNumber,ColNumber,-1):-
   		find_left_up(CurrentBoardStateMatrix,RowNumber,ColNumber,0,0,Friend,_),
   		Friend >= 13,
   		!.
   
   find_win_lu(-2,CurrentBoardStateMatrix,RowNumber,ColNumber,-2):-
   		find_left_up(CurrentBoardStateMatrix,RowNumber,ColNumber,0,0,_,Enemy),
   		Enemy >= 12,
   		!.	
   	
   find_win_ld(-1,CurrentBoardStateMatrix,RowNumber,ColNumber,-1):-
   		find_left_down(CurrentBoardStateMatrix,RowNumber,ColNumber,0,0,Friend,_),
   		Friend >= 13,
   		!.

   find_win_ld(-2,CurrentBoardStateMatrix,RowNumber,ColNumber,-2):-
   		find_left_down(CurrentBoardStateMatrix,RowNumber,ColNumber,0,0,_,Enemy),
   		Enemy >= 12,
   		!.
   	
   	
   find_win_ru(-1,CurrentBoardStateMatrix,RowNumber,ColNumber,-1):-
   		find_right_up(CurrentBoardStateMatrix,RowNumber,ColNumber,0,0,Friend,_),
   		Friend >= 13,
   		!.
   
   find_win_ru(-2,CurrentBoardStateMatrix,RowNumber,ColNumber,-2):-
   		find_right_up(CurrentBoardStateMatrix,RowNumber,ColNumber,0,0,_,Enemy),
   		Enemy>= 12,
   		!.	
   
   find_win_rd(-1,CurrentBoardStateMatrix,RowNumber,ColNumber,-1):-
   		find_right_down(CurrentBoardStateMatrix,RowNumber,ColNumber,0,0,Friend,_),
   		Friend >= 13,
   		!.
   	
   find_win_rd(-2,CurrentBoardStateMatrix,RowNumber,ColNumber,-2):-
   		find_right_down(CurrentBoardStateMatrix,RowNumber,ColNumber,0,0,_,Enemy),
   		Enemy>= 12,
   		!.
   	

% <   \Arbitrator ************************************************************************************************************************************>

   /*
   % ��������� ������� ��������� ������
   execute_renju_debug(CurrentBoardStateMatrix, NextStepRowIndex, NextStepColumnIndex):-
		fill_square(CurrentBoardStateMatrix,CurrentBoardState),
		get_next_step_board(CurrentBoardState, NextStepBoardState),
		get_checked_next_step_board(NextStepBoardState,CheckedNextStepBoardState),
		get_marked_board(CheckedNextStepBoardState, MarkedNextStepBoardState),
		get_square_max_coordinates(MarkedNextStepBoardState, NextStepRowIndex, NextStepColumnIndex),
		change_all_square_value1_to_value2(MarkedNextStepBoardState, 0, 8, ChangedValue1ToValue2),

		write("CurrentBoardState"),nl,
		print_square(CurrentBoardState),nl,nl,
		write("NextStepBoardState"),nl,
		print_square(NextStepBoardState),nl,nl,
		write("CheckedNextStepBoardState"),nl,
		print_square(CheckedNextStepBoardState),nl,nl,
		write("MarkedNextStepBoardState"),nl,
		print_square(MarkedNextStepBoardState),nl,nl,
		write("ChangedValue1ToValue2"),nl,
		print_square(ChangedValue1ToValue2),nl,nl,
		write("NextStepRowIndex "),
		write(NextStepRowIndex),
		nl,
		write("NextStepColumnIndex "),
		write(NextStepColumnIndex),
		nl,nl,nl,
		execute_renju_human_is_black(CurrentBoardStateMatrix, RestrictedBoardState),
		write("RestrictedBoardState"),nl,
		print_matrix(RestrictedBoardState),
		!.
        */      
       
% <   Execute Renju ************************************************************************************************************************************>                                                               
   % �������� ���������� ���� ������������� ���������� (��������� ������ ������� �������)
   execute_renju_ai_is_black(CurrentBoardStateMatrix, NextStepRowIndex, NextStepColumnIndex):-
		fill_square(CurrentBoardStateMatrix,CurrentBoardState),
		get_next_step_board(CurrentBoardState, NextStepBoardState),
		get_checked_next_step_board(NextStepBoardState,CheckedNextStepBoardState),
		get_marked_board(CheckedNextStepBoardState, MarkedNextStepBoardState),
		get_square_max_coordinates(MarkedNextStepBoardState, NextStepRowIndex, NextStepColumnIndex),
		!.
                                                                                                  
   
   % �������� ���������� ���� ������������� ���������� (��������� ������ ������ �������)
   execute_renju_ai_is_white(CurrentBoardStateMatrix, NextStepRowIndex, NextStepColumnIndex):-
		fill_square(CurrentBoardStateMatrix,CurrentBoardState),
		get_next_step_board(CurrentBoardState, NextStepBoardState),
		get_marked_board(NextStepBoardState, MarkedNextStepBoardState),
		get_square_max_coordinates(MarkedNextStepBoardState, NextStepRowIndex, NextStepColumnIndex),
		!.   			
                            
   get_matrix_from_square(square(_,Matrix),AufMatrix):-
		copy_matrix(Matrix,AufMatrix),
		!.

   % �������� ���������� ���� ������������� ���������� (��������� ������ ������� �������) [���������� ������]
   execute_renju_ai_is_black_debug(CurrentBoardStateMatrix, ComputedBoardStateMatrix, NextStepRowIndex, NextStepColumnIndex):-
		fill_square(CurrentBoardStateMatrix,CurrentBoardState),
		get_next_step_board(CurrentBoardState, NextStepBoardState),
		get_checked_next_step_board(NextStepBoardState,CheckedNextStepBoardState),
		get_marked_board(CheckedNextStepBoardState, ComputedBoardState),
		get_matrix_from_square(ComputedBoardState,ComputedBoardStateMatrix),
		get_square_max_coordinates(ComputedBoardState, NextStepRowIndex, NextStepColumnIndex),
		!.
   
   % �������� ���������� ���� ������������� ���������� (��������� ������ ������ �������) [���������� ������]
   execute_renju_ai_is_white_debug(CurrentBoardStateMatrix, ComputedBoardStateMatrix, NextStepRowIndex, NextStepColumnIndex):-
		fill_square(CurrentBoardStateMatrix,CurrentBoardState),
		get_next_step_board(CurrentBoardState, NextStepBoardState),
		get_marked_board(NextStepBoardState, ComputedBoardState),
		get_matrix_from_square(ComputedBoardState,ComputedBoardStateMatrix),
		get_square_max_coordinates(ComputedBoardState, NextStepRowIndex, NextStepColumnIndex),
		!.
   
   % �������� ���������� ����� ������ ��� ������-��������
   execute_renju_human_is_black(CurrentBoardStateMatrix, RestrictedBoardStateMatrix):-
		fill_square(CurrentBoardStateMatrix,CurrentBoardState),
		change_all_square_value1_to_value2(CurrentBoardState, 0, -3, TmpCurrentBoardState),
		get_checked_next_step_board(TmpCurrentBoardState, RestrictedBoardState),
		get_matrix_from_square(RestrictedBoardState,RestrictedBoardStateMatrix),
	!.
                        		
   % ���������, ��������� �� ����                     						  
   execute_renju_check_the_game_end(CurrentBoardStateMatrix, Result):-
		test_func(CurrentBoardStateMatrix,0,Result),!.
% <	Execute Renju ************************************************************************************************************************************>   

% <	Exported procedures ****************************************************************************************************************************************>    
   % �������� ���������� ���� ������������� ���������� (��������� ������ ������� �������)
   export_execute_renju_ai_is_black(CurrentBoardStateList, NextStepRowIndex, NextStepColumnIndex):-
		convert_list_to_matrix(CurrentBoardStateList, CurrentBoardStateMatrix),
		execute_renju_ai_is_black(CurrentBoardStateMatrix, NextStepRowIndex, NextStepColumnIndex),
		!.

   % �������� ���������� ���� ������������� ���������� (��������� ������ ������ �������)
   export_execute_renju_ai_is_white(CurrentBoardStateList, NextStepRowIndex, NextStepColumnIndex):-
		convert_list_to_matrix(CurrentBoardStateList, CurrentBoardStateMatrix),
		execute_renju_ai_is_white(CurrentBoardStateMatrix, NextStepRowIndex, NextStepColumnIndex),
		!.

   % �������� ���������� ���� ������������� ���������� (��������� ������ ������� �������) [���������� ������]
   export_execute_renju_ai_is_black_debug(CurrentBoardStateList, ComputedBoardStateList, NextStepRowIndex, NextStepColumnIndex):-
		convert_list_to_matrix(CurrentBoardStateList, CurrentBoardStateMatrix),
		execute_renju_ai_is_black_debug(CurrentBoardStateMatrix, ComputedBoardStateMatrix, NextStepRowIndex, NextStepColumnIndex),
		convert_matrix_to_list(ComputedBoardStateMatrix, ComputedBoardStateList),
		!.
   
   % �������� ���������� ���� ������������� ���������� (��������� ������ ������ �������) [���������� ������]
   export_execute_renju_ai_is_white_debug(CurrentBoardStateList, ComputedBoardStateList, NextStepRowIndex, NextStepColumnIndex):-
		convert_list_to_matrix(CurrentBoardStateList, CurrentBoardStateMatrix),
		execute_renju_ai_is_white_debug(CurrentBoardStateMatrix, ComputedBoardStateMatrix, NextStepRowIndex, NextStepColumnIndex),
		convert_matrix_to_list(ComputedBoardStateMatrix, ComputedBoardStateList),
		!.

   % �������� ���������� ����� ������ ��� ������-��������
   export_execute_renju_human_is_black(CurrentBoardStateList, RestrictedBoardStateList):-
		convert_list_to_matrix(CurrentBoardStateList, CurrentBoardStateMatrix),
		execute_renju_human_is_black(CurrentBoardStateMatrix, RestrictedBoardStateMatrix),
		convert_matrix_to_list(RestrictedBoardStateMatrix, RestrictedBoardStateList),
		!.
   
   % ���������, ��������� �� ����
   export_execute_renju_check_the_game_end(CurrentBoardStateList, Result):-
		convert_list_to_matrix(CurrentBoardStateList, CurrentBoardStateMatrix),
		execute_renju_check_the_game_end(CurrentBoardStateMatrix, Result),
		!.
                        						  
   % ������������ �������� int-�
   export_execute_test_export_int(IntIn, IntOut):-
		IntOut = IntIn + 10,
		!.      
   % ������������ �������� list-�                              
   export_execute_test_export_list([_|T], IntOut):-
		IntOut = T,
		!.

% <   \Exported procedures ****************************************************************************************************************************************>                                                                

% <\Renju ****************************************************************************************************************************************>
/*
% <Test ******************************************************************************************************************************************>
   
   % ���������� ������� ������� ������
   test_execute_renju_debug():-
		fill_square(
						[[-2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
						[0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
						[0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0],
						[0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
						[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, -1, 0],
						[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1],
						[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1],
						[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1],
						[0, 0, 0, 0, 0, 0, -1, -2, 0, 0, 0, 0, 0, 0, 0],
						[0, 0, 0, 0, 0, 0, -2, -1, 0, 0, 0, 0, 0, 0, 0],
						[0, 0, 0, 0, 0, 0, -1, -2, 0, 0, 0, 0, 0, 0, 0],
						[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
						[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
						[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
						[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]],
						CurrentBoardState
					),          
		execute_renju_debug(CurrentBoardState, _, _),
		!.
   
% <Test ******************************************************************************************************************************************>
*/
GOAL
	/*CurrentBoardStateMatrix = 
				      [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0, -2, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]],
	execute_renju_ai_is_black(CurrentBoardStateMatrix, NextStepRowIndex, NextStepColumnIndex),
	write(NextStepRowIndex),
	nl,write(NextStepColumnIndex),nl.*/
	
	/*CurrentBoardStateMatrix = 
				      [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0, -2, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, -2, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, -2, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, -1, -2, -2, -2, -2, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, -1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, -1, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]],
	execute_renju_check_the_game_end(CurrentBoardStateMatrix, Result),
	nl,write(Result),nl.*/
	
	/*CurrentBoardStateMatrix = 
				      [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, -1, -1, -1, -3, -1, -1, -1, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, -1, -3, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]],
	check_func(CurrentBoardStateMatrix, 0, CurrentBoardStateMatrix, TmpCheckedNextStepBoard),
	print_matrix(TmpCheckedNextStepBoard).*/
	
  renju().