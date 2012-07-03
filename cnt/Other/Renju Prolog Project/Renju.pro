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

   % элемент массивов
   Element = Integer 

   % список элементов
   ElementList = Element *

   % одномерный массив
   Array = array 
   (
		  Integer _Size,    % размер массива
		  ElementList _List % список элементов
   )
   
   % матрица из элементов
   ElementMatrix = ElementList * 

   % квадратная матрица
   Square = square 
   (
		  Integer _Size,        % размер матрицы
		  ElementMatrix _Square % список элементов
   )

global predicates
   renju()
 
% <Exported procedures ****************************************************************************************************************************************>  
   
	% получить координаты хода компьютерного противника (компьютер играет черными камнями)
	procedure export_execute_renju_ai_is_black
	(
		ElementList, % [IN]  текущее состояние игровой доски
		Integer,     % [OUT] индекс строки хода
		Integer      % [OUT] индекс столбца хода
	)
	-
	(
		i,
		o,
		o
	) language stdcall
   
	% получить координаты хода компьютерного противника (компьютер играет белыми камнями)
	procedure export_execute_renju_ai_is_white
	(
		ElementList, % [IN]  текущее состояние игровой доски
		Integer,     % [OUT] индекс строки хода
		Integer      % [OUT] индекс столбца хода
	)
	-
	(
		i,
		o,
		o
	) language stdcall
   
	% получить координаты хода компьютерного противника (компьютер играет черными камнями) [ОТЛАДОЧНАЯ ВЕРСИЯ]
	procedure export_execute_renju_ai_is_black_debug
	(
		ElementList, % [IN]  текущее состояние игровой доски
		ElementList, % [OUT] рассчитанная доска
		Integer,     % [OUT] индекс строки хода
		Integer      % [OUT] индекс столбца хода
	)
	-
	(
		i,
		o,
		o,
		o
	) language stdcall
   
	% получить координаты хода компьютерного противника (компьютер играет белыми камнями) [ОТЛАДОЧНАЯ ВЕРСИЯ]
	procedure export_execute_renju_ai_is_white_debug
	(
		ElementList,   % [IN]  текущее состояние игровой доски
		ElementList,   % [OUT] рассчитанная доска
		Integer,       % [OUT] индекс строки хода
		Integer        % [OUT] индекс столбца хода
	)
	-
	(
		i,
		o,
		o,
		o
	) language stdcall
   
	% получить координаты фолов черных для игрока-человека
	procedure export_execute_renju_human_is_black
	(
		ElementList, 	% [IN]  текущее состояние игровой доски
		ElementList  	% [OUT] текущее состояние игровой доски с запрещенными ходами
	)
	-
	(
		i,
		o
	) language stdcall
   
	% проверить, кончилась ли игра
	procedure export_execute_renju_check_the_game_end
	(
		ElementList, 	% [IN] текущее состояние игровой доски
		Integer       	% [OUT] 0 - никто не победил, -1 - черный победил, -2 - белый победил
	)
	-
	(
		i,
		o
	) language stdcall
   
	% тестирование экспорта int
	procedure export_execute_test_export_int
	(
		Integer,   	%  [IN] текущее состояние игровой доски
		Integer    	%  [OUT]
	)
	-
	(
		i,
		o
	) language stdcall
   
	% тестирование экспорта list-а
	procedure export_execute_test_export_list
	(
		ElementList,   	%  [IN]
		ElementList    	%  [OUT] текущее состояние игровой доски с запрещенными ходами
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
	% преобразовать список в матрицу 15х15
	nondeterm convert_list_to_matrix
	(
		ElementList,		% [IN] лист для конвертеризации
		ElementMatrix		% [OUT] выходная квадратная матрица
	)
	-
	(
		i,
		o
	)

	% преобразовать матрицу 15х15 в список	     
	nondeterm convert_matrix_to_list
	(
		ElementMatrix, 		% [IN] квадратная матрица для конвертеризации
		ElementList		% [OUT] выходной лист 
	)
	-
	(
		i,
		o
	)
	
	%< внутренние предикат преобразования лист-матрица>
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
	
	% пишет элемент в матрицу, возвращая координаты следующего элемента
	nondeterm write_element_to_matrix
	(
		Element,		%[IN] Записываемый элемент
		ElementMatrix,		%[IN] Исходная матрица
		Integer,		%[IN] Х координата для записи
		Integer,		%[IN] У координата
		Integer,		%[OUT] Х координата следующей записи
		Integer,		%[OUT] У координата слудующей записи
		ElementMatrix		%[OUT] Результрующая матрица
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

	% копирует тело листа в матрицу
	nondeterm copy_body
	(
		ElementList,		%[IN] Копируемый лист
		ElementMatrix,		%[IN] Исходная матрица
		Integer,		%[IN] Начальные координаты
		Integer,		%[IN] в матрице (ставятся 1;0, так как 0;0 - голова списка)
		ElementList		%[OUT] Результат
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
   
	% найти длину списка
	nondeterm get_list_size
	(
		ElementList,		% [IN] список
		Integer			% [OUT] длина списка
	)
	-
	(
		i,
		o
	)

	% получить элемента списка по его номеру
	nondeterm get_list_element
	(
		ElementList,		% [IN] список
		Integer,		% [IN] индекс элемента (индексация начинается с 0)
		Element			% [OUT] элемент с данным номером
	)
	-
	(
		i,
		i,
		o
	)

	% присвоить элементу списка новое значение
	nondeterm set_list_element
	(
		ElementList,		%  [IN] список
		Integer,		%  [IN] индекс элемента (индексация начинается с 0)
		Element,		%  [IN] новое значение элемента с данным номером
		ElementList		%  [OUT] сформированный список
	)
	-
	(
		i,
		i,
		i,
		o
	)
   
	% добавить к списку число
	nondeterm append_to_list
	(
		ElementList,		%  [IN] Входной список
		Element,		%  [IN]	Записываемый элемент
		ElementList		%  [OUT] Результат
	)
	-
	(
		i,
		i,
		o
	)

	% напечатать список
	nondeterm print_list
	(
		ElementList		% [IN] список
	)
	-
	(
		i
	)

	% получить число строк матрицы
	nondeterm get_matrix_row_count
	(
		ElementMatrix,		% [IN] матрица
		Integer			% [OUT] количество строк
	)
	-
	(
		i,
		o
	)

	% получить строку матрицы по её номеру
	nondeterm get_matrix_row
	(
		ElementMatrix, 	% [IN] матрица
		Integer, 	% [IN] номер строки (индексация начинается с 0)
		ElementList	% [OUT] строка матрицы
	)
	-
	(
		i,
		i,
		o
	)

	% присвоить строке матрицы новое значение
	nondeterm set_matrix_row
	(
		ElementMatrix,	% [IN] матрица
		Integer,	% [IN] номер строки (индексация начинается с 0)
		ElementList,	% [IN] новое значение строки матрицы
		ElementMatrix	% [OUT] сформированная матрица
	)
	-
	(
		i,
		i,
		i,
		o
	)

	% получить элемент матрицы по его координатам
	nondeterm get_matrix_element
	(
		ElementMatrix,		% [IN] матрица
		Integer,		% [IN] номер строки (индексация начинается с 0)
		Integer,		% [IN] номер столбца (индексация начинается с 0)
		Element			% [OUT] элемент матрицы
	)
	-
	(
		i,
		i,
		i,
		o
	)

	% присвоить элементу матрицы новое значение
	nondeterm set_matrix_element
	(
		ElementMatrix,		% [IN] матрица
		Integer,		% [IN] номер строки (индексация начинается с 0)
		Integer,		% [IN] номер столбца (индексация начинается с 0)
		Element,		% [IN] новое значение элемента
		ElementMatrix		% [OUT] сфоормированная матрица
	)
	-
	(
		i,
		i,
		i,
		i,
		o
	)
   
	% копировать матрицу
	nondeterm copy_matrix
	(
		ElementMatrix,	% [IN] матрица-источник
		ElementMatrix	% [OUT] матрица-приемник
	)
	-
	(
		i,
		o
	)
   
	% печать матрицы
	nondeterm print_matrix
	(
		ElementMatrix	% [IN] матрица
	)
	-
	(
		i
	)

	% заполнить массив
	nondeterm fill_array
	(
		ElementList,		% [IN] данные для заполнения
		Array			% [OUT] результирующий массив
	)
	-
	(
		i,
		o
	)

	% копировать массив
	nondeterm copy_array
	(
		Array,			% [IN] массив-источник
		Array			% [OUT] массив-приемник
		)
	-
	(
		i,
		o
	)

	% получить элемент массива по его индексу
	nondeterm get_array_element
	(
		Array,			% [IN] массив
		Integer,		% [IN] индекс элемента (индексация начинается с 0)
		Element			% [OUT] элемент с данным номером
	)
	-
	(
		i,
		i,
		o
	)

	% присвоить элементу массива новое значение
	nondeterm set_array_element
	(
		Array,			% [IN] массив
		Integer,		% [IN] индекс элемента (индексация начинается с 0)
		Element,		% [IN] новое значение элемента
		Array			% [OUT] сформированный массив
	)
	-
	(
		i,
		i,
		i,
		o
	)

	% печатать массив
	nondeterm print_array
	(
		Array			% [IN] массив
	)
	-
	(
		i
	)

	% заполнить квадратную матрицу
	nondeterm fill_square
	(
		ElementMatrix,		% [IN] данные для заполнения
		Square			% [OUT] результирующая кввадратная матрица
	)
	-
	(
		i,
		o
	)
	
	% Извлечь матрицу из квадратной матрицы
	nondeterm get_matrix_from_square
	(
		Square,			% Исходная квадратная матрица
		ElementMatrix	% извлеченная матрица
	)
	-
	(
		i,
		o
	)

	% копировать квадратную матрицу
	nondeterm copy_square
	(
		Square,			% [IN] квадратная матрица-источник
		Square			% [OUT] квадратная матрица-приемник
	)
	-
	(
		i,
		o
	)

	% получить элемент квадратной матрицы
	nondeterm get_square_element
	(
		Square,			% [IN] квадратная матрица
		Integer,		% [IN] индекс строки элемента
		Integer,		% [IN] индекс столбца элемента
		Element			% [OUT] элемент с данными индексами
	)
	-
	(
		i,
		i,
		i,
		o
	)

	% присвоить элементу квадратной матрицы новое значение
	nondeterm set_square_element
	(
		Square,			% [IN] квадратная матрица
		Integer,		% [IN] индекс строки элемента
		Integer,		% [IN] индекс столбца элемента
		Element,		% [IN] новое значение элемента
		Square			% [OUT] сформированная квадратная матрица
	)
	-
	(
		i,
		i,
		i,
		i,
		o
	)

	% получить размер квадратнйо матрицы
	nondeterm get_square_size
	(
		Square,			%  [IN] квадратная матрица
		Integer			%  [OUT] размер квадратной матрицы
	)
	-
	(
		i,
		o
	)

	% получить координаты максимума квадратной матрицы
	nondeterm get_square_max_coordinates
	(
		Square,			% [IN] квадратная матрица
		Integer,		% [OUT] индекс строки максимального элемента
		Integer			% [OUT] индекс столбца максимального элемента
	)
	-
	(
		i,
		o,
		o
	)

	% получить координаты максимума квадратной матрицы (вспомогательный рекурсивный предикат - итерация по строкам)
	nondeterm get_square_max_coordinates_rows
	(
		Square,			% [IN] квадратная матрица
		Integer,		% [IN] индекс строки текущего элемента
		Integer,		% [IN] индекс столбца текущего элемента
		Integer,		% [IN] текущий индекс строки максимального элемента
		Integer,		% [IN] текущий индекс столбца максимального элемента
		Integer,		% [OUT] индекс строки нового максимального элемента
		Integer			% [OUT] индекс столбца нового максимального элемента
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

	% получить координаты максимума квадратной матрицы (вспомогательный рекурсивный предикат - итерация по колонкам)
	nondeterm get_square_max_coordinates_columns
	(
		Square,			% [IN] квадратная матрица
		Integer,		% [IN] индекс строки текущего элемента
		Integer,		% [IN] индекс столбца текущего элемента
		Integer,		% [IN] текущий индекс строки максимального элемента
		Integer,		% [IN] текущий индекс столбца максимального элемента
		Integer,		% [OUT] индекс строки нового максимального элемента
		Integer			% [OUT] индекс столбца нового максимального элемента
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

	% заменяет в квадратной матрице все значения элементов, равные value1, на value2
	nondeterm change_all_square_value1_to_value2
	(
		Square,			% [IN] квадратная матрица
		Integer,		% [IN] заменяемое значение value1
		Integer,		% [IN] заменяющее значение value2
		Square			% [OUT] результирующая квадратная матрица
	)
	-
	(
		i,
		i,
		i,
		o
	)

	% заменяет в квадратной матрице все значения элементов, равные value1, на value2 (вспомогательный рекурсивный предикат - итерация по строкам)
	nondeterm change_all_square_value1_to_value2_rows
	(
		Square,			% [IN] квадратная матрица
		Integer,		% [IN] индекс строки текущего элемента
		Integer,		% [IN] индекс столбца текущего элемента
		Integer,		% [IN] заменяемое значение value1
		Integer,		% [IN] заменяющее значение value2
		Square			% [OUT] результирующая квадратная матрица
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

	% заменяет в квадратной матрице все значения элементов, равные value1, на value2 (вспомогательный рекурсивный предикат - итерация по колонкам)
	nondeterm change_all_square_value1_to_value2_columns
	(
		Square,			% [IN] квадратная матрица
		Integer,		% [IN] индекс строки текущего элемента
		Integer,		% [IN] индекс столбца текущего элемента
		Integer,		% [IN] заменяемое значение value1
		Integer,		% [IN] заменяющее значение value2
		Square			% [OUT] результирующая квадратная матрица
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

	% печать квадратной матрицы
	nondeterm print_square
	(
		Square			% [IN] квадратная матрица
	)
	-
	(
		i
	)
   
% <\Lists and arrays *****************************************************************************************************************************>


% <Renju *****************************************************************************************************************************************>

% <   Next Step Board Generation ********************************************************************************************************************>

	% получить доску с отмеченными возможными вариантами следующего хода
	nondeterm get_next_step_board
	(
		Square,			% [IN] текущая доска
		Square			% [OUT ]доска с отмеченными возможными вариантами следующего хода
	)
	-
	(
		i,
		o
	)
   
	% перебрать все строки матрицы текущего состояния, чтобы отметить возможные варианты следующего хода
	nondeterm get_next_step_board_rows
	(
		Integer,		% [IN] индекс текущей строки матрицы текущего состояния
		Integer,		% [IN] число колонок матрицы текущего состояния
		Square,			% [IN] матрица текущего состояния
		Square			% [OUT] матрица с отмеченными возможными вариантами следующего хода
	)
	-
	(
		i,
		i,
		i,
		o
	)
   
	% перебрать все колонки текущей строки матрицы текущего состояния, чтобы отметить возможные варианты следующего хода
	nondeterm get_next_step_board_columns
	(
		Integer,		% [IN] индекс текущей строки матрицы текущего состояния
		Integer,		% [IN] индекс текущей колонки матрицы текущего состояния
		Square,			% [IN] матрица текущего состояния
		Square			% [OUT] матрица с отмеченными возможными вариантами следующего хода
	)
	-
	(
		i,
		i,
		i,
		o
	)
   
	% установить в текущую координату центр расходяшейся звезды следующих шагов
	nondeterm set_next_step_star_center
	(
		Integer,		% [IN] индекс текущей строки матрицы текущего состояния
		Integer,		% [IN] индекс текущей колонки матрицы текущего состояния
		Square,			% [IN] матрица текущего состояния
		Square			% [OUT] матрица с отмеченными возможными вариантами следующего хода
	)
	-
	(
		i,
		i,
		i,
		o
	)
   
	% установить в текущую координату "элемент" луча расходяшейся звезды следующих шагов
	nondeterm set_next_step_star_ray_element
	(
		Integer,		% [IN] индекс текущей строки матрицы текущего состояния
		Integer,		% [IN] индекс текущей колонки матрицы текущего состояния
		Square,			% [IN] матрица текущего состояния
		Square			% [OUT] матрица с отмеченными возможными вариантами следующего хода
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
   
	% оценить эффективность каждого возможного хода
	nondeterm get_marked_board
	(
		Square,			% [IN] текущее состояние игровой доски с отмеченными вариантами следующего хода
		Square			% [OUT] текущее состояние игровой доски с оцененными вариантами следующего хода
	)
	-
	(
		i,
		o
	)

	nondeterm mark_func % оценочная функция
	(
		ElementMatrix Exist,			% [IN] Входная матрица расположений, -1- своя фишка, -2 - врага, 0 - запрещен расчет, -3 - разрешен
		Integer RowNumber,			% [IN] Начальная строка. Используется внутри предиката, нужно ставить в 0.
		ElementMatrix StartMarkMatrix,		% [IN] Начальная матрица оценок
		ElementMatrix NewMarkMatrix		% [OUT] Матрица оценок
	)
	-
	(
		i,
		i,
		i,
		o
	)
	
	nondeterm mark_row % оценочная функция для строки в матрице
	(
		ElementMatrix Exist,				% [IN] Входная матрица расположений, -1- своя фишка, -2 - врага, 0 - запрещен расчет, -3 - разрешен
		Integer RowNumber,				% [IN] Номер строки
		Integer ColNumber,				% [IN] Начальный столбец. Используется внутри предиката, нужно ставить в 0.
		ElementMatrix StartMarkMatrix, 			% [IN] Начальная матрица оценок
		ElementMatrix NewMarkMatrix			% [OUT] Матрица оценок
	)
	-
	(
		i,
		i,
		i,
		i,
		o
	)
	
	nondeterm mark_element % расчет оценки элемента матрицы
	(
		ElementMatrix Exist,			% [IN] Входная матрица расположений, -1- своя фишка, -2 - врага, 0 - запрещен расчет, -3 - разрешен
		Integer RowNumber,			% [IN] Номер строки
		Integer ColNumber,			% [IN] Номер столбца
		Element ResMark				% [OUT] Оценка
	)
	-
	(
		i,
		i,
		i,
		o
	)
		
	nondeterm is_not_changed % проверка на смену цвета с ряду
	(
		Element StartMarkFriend,	% [IN] Текущая оценка для своих
		Element StartMarkEnemy,		% [IN] Текущая оценка для чужих
		Element Elem			% [IN] Значение в ячейке
	)
	-
	(
		i,
		i,
		i
	)
		
	nondeterm find_left % Суммирование очков слева
	(
		ElementMatrix Exist,		% [IN] Входная матрица расположений, -1- своя фишка, -2 - врага, 0 - запрещен расчет, -3 - разрешен
		Integer RowNumber,		% [IN] Номер строки
		Integer ColNumber,		% [IN] Номер столбца
		Element StartMarkFriend,	% [IN] Стартовая оценка для своих
		Element StartMarkEnemy,		% [IN] Стартовая оценка для вражеских
		Element NewMarkFriend,		% [OUT] Итоговая оценка для своих
		Element NewMarkEnemy		% [OUT] Итоговая оценка для вражеских
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
	nondeterm find_right % Суммирование очков справа
	(
		ElementMatrix Exist,		% [IN] Входная матрица расположений, -1- своя фишка, -2 - врага, 0 - запрещен расчет, -3 - разрешен
		Integer RowNumber,		% [IN] Номер строки
		Integer ColNumber,		% [IN] Номер столбца
		Element StartMarkFriend,	% [IN] Стартовая оценка для своих
		Element StartMarkEnemy,		% [IN] Стартовая оценка для вражеских
		Element NewMarkFriend,		% [OUT] Итоговая оценка для своих
		Element NewMarkEnemy		% [OUT] Итоговая оценка для вражеских
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
	nondeterm find_up % Суммирование очков сверху
	(
		ElementMatrix Exist,		% [IN] Входная матрица расположений, -1- своя фишка, -2 - врага, 0 - запрещен расчет, -3 - разрешен
		Integer RowNumber,		% [IN] Номер строки
		Integer ColNumber,		% [IN] Номер столбца
		Element StartMarkFriend,	% [IN] Стартовая оценка для своих
		Element StartMarkEnemy,		% [IN] Стартовая оценка для вражеских
		Element NewMarkFriend,		% [OUT] Итоговая оценка для своих
		Element NewMarkEnemy		% [OUT] Итоговая оценка для вражеских
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
	nondeterm find_down % Суммирование очков снизу
	(
		ElementMatrix Exist,		% [IN] Входная матрица расположений, -1- своя фишка, -2 - врага, 0 - запрещен расчет, -3 - разрешен
		Integer RowNumber,		% [IN] Номер строки
		Integer ColNumber,		% [IN] Номер столбца
		Element StartMarkFriend,	% [IN] Стартовая оценка для своих
		Element StartMarkEnemy,		% [IN] Стартовая оценка для вражеских
		Element NewMarkFriend,		% [OUT] Итоговая оценка для своих
		Element NewMarkEnemy		% [OUT] Итоговая оценка для вражеских
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
	nondeterm find_left_up % Суммирование очков слева-сверху
	(
		ElementMatrix Exist,		% [IN] Входная матрица расположений, -1- своя фишка, -2 - врага, 0 - запрещен расчет, -3 - разрешен
		Integer RowNumber,		% [IN] Номер строки
		Integer ColNumber,		% [IN] Номер столбца
		Element StartMarkFriend,	% [IN] Стартовая оценка для своих
		Element StartMarkEnemy,		% [IN] Стартовая оценка для вражеских
		Element NewMarkFriend,		% [OUT] Итоговая оценка для своих
		Element NewMarkEnemy		% [OUT] Итоговая оценка для вражеских
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
	nondeterm find_right_up % Суммирование очков справа-сверху
	(
		ElementMatrix Exist,		% [IN] Входная матрица расположений, -1- своя фишка, -2 - врага, 0 - запрещен расчет, -3 - разрешен
		Integer RowNumber,		% [IN] Номер строки
		Integer ColNumber,		% [IN] Номер столбца
		Element StartMarkFriend,	% [IN] Стартовая оценка для своих
		Element StartMarkEnemy,		% [IN] Стартовая оценка для вражеских
		Element NewMarkFriend,		% [OUT] Итоговая оценка для своих
		Element NewMarkEnemy		% [OUT] Итоговая оценка для вражеских
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
	nondeterm find_right_down % Суммирование очков справа-сверху
	(
		ElementMatrix Exist,		% [IN] Входная матрица расположений, -1- своя фишка, -2 - врага, 0 - запрещен расчет, -3 - разрешен
		Integer RowNumber,		% [IN] Номер строки
		Integer ColNumber,		% [IN] Номер столбца
		Element StartMarkFriend,	% [IN] Стартовая оценка для своих
		Element StartMarkEnemy,		% [IN] Стартовая оценка для вражеских
		Element NewMarkFriend,		% [OUT] Итоговая оценка для своих
		Element NewMarkEnemy		% [OUT] Итоговая оценка для вражеских
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
	nondeterm find_left_down % Суммирование очков слева-сверху
	(
		ElementMatrix Exist,		% [IN] Входная матрица расположений, -1- своя фишка, -2 - врага, 0 - запрещен расчет, -3 - разрешен
		Integer RowNumber,		% [IN] Номер строки
		Integer ColNumber,		% [IN] Номер столбца
		Element StartMarkFriend,	% [IN] Стартовая оценка для своих
		Element StartMarkEnemy,		% [IN] Стартовая оценка для вражеских
		Element NewMarkFriend,		% [OUT] Итоговая оценка для своих
		Element NewMarkEnemy		% [OUT] Итоговая оценка для вражеских
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
	nondeterm add_mark_for_element % Расчет количества очков для данной ячейки
	(
		Element Elem,			% [IN] Значение в ячейке
		Element StartMarkFriend,	% [IN] Стартовая оценка для своих
		Element StartMarkEnemy,		% [IN] Стартовая оценка для вражеских
		Element AddMarkFriend,		% [OUT] Итоговая оценка для своих
		Element AddMarkEnemy		% [OUT] Итоговая оценка для вражеских
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
	% проверка на фолы. Свои - черные
	nondeterm get_checked_next_step_board
	(
		Square NextStepBoardState, 		% [IN]Исходная матрица расположений
		Square CheckedNextStepBoardState	% [OUT] Разрешенные позиии с учетом фолов
	)
	-
	(
		i,
		o
	)
	
	% проверка на фолы всей матрицы		
	nondeterm check_func
	(
		ElementMatrix Exist,		% [IN] Входная матрица расположений, -1- своя фишка, -2 - врага, 0 - запрещен расчет, -3 - разрешен
		Integer RowNumber,		% [IN] Начальная строка. Используется внутри предиката, нужно ставить в 0.
		ElementMatrix StartMatrix,	% [IN] Начальная матрица расположений
		ElementMatrix NewMatrix		% [OUT] Матрица расположений
	)
	-
	(
		i,
		i,
		i,
		o
	)
	
	% проверка на фолы одной строки		
	nondeterm check_row
	(
		ElementMatrix Exist,		% [IN] Входная матрица расположений, -1- своя фишка, -2 - врага, 0 - запрещен расчет, -3 - разрешен
		Integer RowNumber,		% [IN] Номер строки
		Integer ColNumber,		% [IN] Начальный столбец. Используется внутри предиката, нужно ставить в 0.
		ElementMatrix StartMatrix, 	% [IN] Начальная матрица оценок
		ElementMatrix NewMatrix		% [OUT] Матрица расположений
	)
	-
	(
		i,
		i,
		i,
		i,
		o
	)
   
	% проверка на фолы одного элемента		
	nondeterm check_element
	(
		ElementMatrix Exist,	% [IN] Входная матрица расположений, -1- своя фишка, -2 - врага, 0 - запрещен расчет, -3 - разрешен
		Integer RowNumber,	% [IN] Номер строки
		Integer ColNumber,	% [IN] Номер столбца
		Element CheckState	% [OUT] Разрешение позиции
	)
	-
	(
		i,
		i,
		i,
		o
	)

	% проверка, закончена ли игра
	nondeterm test_func
	(
		ElementMatrix,			% матрица с состоянием
		Integer,			% зарезервировано, устанавливается в 0
		Integer				% Результат -1 - выйграли свои, -2 - чужие, 0 - никто
	)
	-
	(
		i,
		i,
		o
	)
	
	% проверка элементов строки на комбинации конца игры
	nondeterm test_row
	(
		ElementMatrix,			% Матрица состояния
		Integer,			% номер строки
		Integer,			% зарезервировано, устанавливается в 0
		Integer				% резульатат
	)
	-
	(
		i,
		i,
		i,
		o
	)
	
	% проверить элемент на включение в комбинацию конца игры
	nondeterm test_element
	(
		ElementMatrix,			% матрица состояния
		Integer,			% номер строки
		Integer,			% номер столбца
		Integer				% результат
	)
	-
	(
		i,
		i,
		i,
		o
	)
	
	% найти выйгрышную комбинацию вокруг элемента
	nondeterm find_win
	(
		Integer,				% тип элемента -1, -2
		ElementMatrix,				% Матрица состояния
		Integer,				% координаты
		Integer,				% --/--
		Integer					% Резульатат
	)
	-
	(
		i,
		i,
		i,
		i,
		o
	)
	
	%< проверка на комбинации выйгрыша во всех восьми направлениях>
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
   %<\ проверка на комбинации выйгрыша во всех восьми направлениях>
   
% <   \Arbitrator ************************************************************************************************************************************>

% <   Execute Renju ************************************************************************************************************************************>
	% получить координаты хода компьютерного противника (компьютер играет черными камнями)
	nondeterm execute_renju_ai_is_black
	(
		ElementMatrix,			% [IN]  текущее состояние игровой доски
		Integer,			% [OUT] индекс строки хода
		Integer				% [OUT] индекс столбца хода
	)
	-
	(
		i,
		o,
		o
	)
   
	% получить координаты хода компьютерного противника (компьютер играет белыми камнями)
	nondeterm execute_renju_ai_is_white
	(
		ElementMatrix,			% [IN]  текущее состояние игровой доски
		Integer,			% [OUT] индекс строки хода
		Integer				% [OUT] индекс столбца хода
	)
	-
	(
		i,
		o,
		o
	)
   
	% получить координаты хода компьютерного противника (компьютер играет черными камнями) [ОТЛАДОЧНАЯ ВЕРСИЯ]
	nondeterm execute_renju_ai_is_black_debug
	(
		ElementMatrix,			% [IN]  текущее состояние игровой доски
		ElementMatrix,			% [OUT] рассчитанная доска
		Integer,			% [OUT] индекс строки хода
		Integer				% [OUT] индекс столбца хода
	)
	-
	(
		i,
		o,
		o,
		o
	)
   
	% получить координаты хода компьютерного противника (компьютер играет белыми камнями) [ОТЛАДОЧНАЯ ВЕРСИЯ]
	nondeterm execute_renju_ai_is_white_debug
	(
		ElementMatrix,			% [IN]  текущее состояние игровой доски
		ElementMatrix,			% [OUT] рассчитанная доска
		Integer,			% [OUT] индекс строки хода
		Integer				% [OUT] индекс столбца хода
	)
	-
	(
		i,
		o,
		o,
		o
	)
   
	% получить координаты фолов черных для игрока-человека
	nondeterm execute_renju_human_is_black
	(
		ElementMatrix,		%  [IN]  текущее состояние игровой доски
		ElementMatrix		%  [OUT] текущее состояние игровой доски с запрещенными ходами
	)
	-
	(
		i,
		o
	)
   
	% проверить, кончилась ли игра
	nondeterm execute_renju_check_the_game_end
	(
		ElementMatrix,			% [IN] текущее состояние игровой доски
		Integer				% [OUT] 0 - никто не победил, -1 - свой победил, -2 - чужой победил
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
   
	% найти длину списка
	get_list_size([], Size):-
			Size = 0,
			!.
	get_list_size([_ | EL_T], NewSize):-
			get_list_size(EL_T, Size),
			NewSize = Size + 1,
			!.

	% найти элемент списка по его номеру
	get_list_element([EL_H | _], 0, EL_H):-
			!.
	        
	get_list_element([_ | EL_T], Index, E):-
			Index >= 0,
			NewIndex = Index - 1,
			get_list_element(EL_T, NewIndex, E),
			!.

	% присвоить элементу списка новое значение
	set_list_element([_ | EL_T], 0, E, [E | EL_T]):-
			!.
	                    
	set_list_element([EL_H | EL_T], Index, E, [EL_H | New_EL_T]):-
			Index >= 0,
			NewIndex = Index - 1,
			set_list_element(EL_T, NewIndex, E, New_EL_T),
			!.

	% печатать список
	print_list([]):-
			!.
	print_list([EL_H | EL_T]):-
			  write(" "),
			  write(EL_H),
			  print_list(EL_T),
			!.

	% получить количество строк матрицы
	get_matrix_row_count([], 0):-
			!.
	        
	get_matrix_row_count([_ | EM_T], NewSize):-
			get_matrix_row_count(EM_T, Size),
			NewSize = Size + 1,
			!.

	% получить строки матрицы по ее номеру
	get_matrix_row([EM_H | _], 0, EM_H):-
			!.
	                    
	get_matrix_row([_ | EM_T], Index, R):-
			Index >= 0,
			NewIndex = Index - 1,
			get_matrix_row(EM_T, NewIndex, R),
			!.

	% присвоить строке матрицы новое значение
	set_matrix_row([_ | EM_T], 0, R, [R | EM_T]):-
			!.
			
	set_matrix_row([EM_H | EM_T], Index, R, [EM_H | New_EM_T]):-
			Index >= 0,
			NewIndex = Index - 1,
			set_matrix_row(EM_T, NewIndex, R, New_EM_T),
			!.

	% получить элемент матрицы по его координатам
	get_matrix_element(EM, RowIndex, ColumnIndex, Element):-
			get_matrix_row(EM, RowIndex, R),
			get_list_element(R, ColumnIndex, Element),
			!.

	% присвоить элементу матрицы новое значение
	set_matrix_element(EM, RowIndex, ColumnIndex, Element, New_EM):-
			get_matrix_row(EM, RowIndex, R),
			set_list_element(R, ColumnIndex, Element, New_R),
			set_matrix_row(EM, RowIndex, New_R, New_EM),
			!.
	 
	% копировать матрицу
	copy_matrix(Matrix,Matrix):-
			!.

	% печатать матрицу
	print_matrix([]):-
			!.
	        
	print_matrix([EM_H | EM_T]):-
			print_list(EM_H),
			nl,
			print_matrix(EM_T),
			!.

	% заполнить массив
	fill_array(EL, array(Size, EL)):-
			get_list_size(EL, Size),
			!.

	% копировать массив
	copy_array(array(Size, List), array(Size, List)):-
			!.

	% найти элемент массива по его индексу
	get_array_element(array(_, EL), Index, E):-
			get_list_element(EL, Index, E),
			!.

	% присвоить элементу массива новое значение
	set_array_element(array(Size, EL), Index, E, array(Size, New_EL)):-
			set_list_element(EL, Index, E, New_EL),
			!.

	% печатать массив
	print_array(array(Size, List)):-
			write(Size),
			write(":"),
			print_list(List),
			nl,
			!.

	% заполненить квадратную матрицу
	fill_square(EM, square(Size, EM)):-
			get_matrix_row_count(EM, Size),
			!.

	% копировать квадратную матрицу
	copy_square(square(Size, Matrix), square(Size, Matrix)):-
			!.

	% получить элемент квадратной матрицы по его индексам
	get_square_element(square(_, EM), RowIndex, ColumnIndex, E):-
			get_matrix_element(EM, RowIndex, ColumnIndex, E),
			!.

	% присвоить элементу квадратной матрицы новое значение
	set_square_element(square(Size, EM), RowIndex, ColumnIndex, E, square(Size, New_EM)):-
			set_matrix_element(EM, RowIndex, ColumnIndex, E, New_EM),
			!.
	                                                                                     
	% получить размер квадратнйо матрицы
	get_square_size(square(Size, _), Size):-
			!.

	% получить координаты максимума квадратной матрицы
	get_square_max_coordinates(Square, MaxRowIndex, MaxColumnIndex):-
			get_square_size(Square, BoardSize),
			BoardIndexSize = BoardSize - 1,
			get_square_max_coordinates_rows(Square, BoardIndexSize, BoardIndexSize, BoardIndexSize, BoardIndexSize, MaxRowIndex, MaxColumnIndex),
			!.

	% получить координаты максимума квадратной матрицы (вспомогательный рекурсивный предикат)
	get_square_max_coordinates_rows(_, -1, _, CurrentMaxRowIndex, CurrentMaxColumnIndex, CurrentMaxRowIndex, CurrentMaxColumnIndex):-
			!.
			
	get_square_max_coordinates_rows(Square, CurrentRowIndex, CurrentColumnIndex, CurrentMaxRowIndex, CurrentMaxColumnIndex, NewMaxRowIndex, NewMaxColumnIndex):-
			get_square_max_coordinates_columns(Square, CurrentRowIndex, CurrentColumnIndex, CurrentMaxRowIndex, CurrentMaxColumnIndex, TmpNewMaxRowIndex, TmpNewMaxColumnIndex),
			NextRowIndex = CurrentRowIndex - 1,
			get_square_max_coordinates_rows(Square, NextRowIndex, CurrentColumnIndex, TmpNewMaxRowIndex, TmpNewMaxColumnIndex, NewMaxRowIndex, NewMaxColumnIndex),
			!.
	  
	% получить координаты максимума квадратной матрицы (вспомогательный рекурсивный предикат)
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

	% заменяет в квадратной матрице все значения элементов, равные value1, на value2
	change_all_square_value1_to_value2(Square1, Value1, Value2, Square2):-
			get_square_size(Square1, SquareSize),
			SquareIndexSize = SquareSize - 1,
			change_all_square_value1_to_value2_rows(Square1, SquareIndexSize, SquareIndexSize, Value1, Value2, Square2),
			!.
	                                                                     

	% заменяет в квадратной матрице все значения элементов, равные value1, на value2 (вспомогательный рекурсивный предикат - итерация по строкам)
	change_all_square_value1_to_value2_rows(Square1, -1, _, _, _, Square1):-
			!.
	                    
	change_all_square_value1_to_value2_rows(Square1, CurrentRowIndex, CurrentColumnIndex, Value1, Value2, Square2):-
			change_all_square_value1_to_value2_columns(Square1, CurrentRowIndex, CurrentColumnIndex, Value1, Value2, TmpSquare1),
			NextRowIndex = CurrentRowIndex - 1,
			change_all_square_value1_to_value2_rows(TmpSquare1, NextRowIndex, CurrentColumnIndex, Value1, Value2, Square2),
			!.

	% заменяет в квадратной матрице все значения элементов, равные value1, на value2 (вспомогательный рекурсивный предикат - итерация по колонкам)
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

   % печать квадратной матрицы
	print_square(square(Size, EM)):-
			write(Size),
			write(":"),
			nl,
			print_matrix(EM),
			!.

% <\Lists and arrays *****************************************************************************************************************************>

% <Renju *****************************************************************************************************************************************>

% <Next Step Board Generation ********************************************************************************************************************>

	% получить доску с отмеченными возможными вариантами следующего хода
	get_next_step_board(CurrentBoardState, NextStepBoardState):-
			get_square_size(CurrentBoardState, BoardSize),
			MaxBoardIndex = BoardSize - 1,
			get_next_step_board_rows(MaxBoardIndex, MaxBoardIndex, CurrentBoardState, NextStepBoardState),
			!.
	                                                           
	% перебрать все строки матрицы текущего состояния, чтобы отметить возможные варианты следующего хода
	get_next_step_board_rows(-1, _, CurrentBoardState, CurrentBoardState):-
			!.
			
	get_next_step_board_rows(CurrentRowIndex, ColumnCount, CurrentBoardState, NextStepBoardState):-
			get_next_step_board_columns(CurrentRowIndex, ColumnCount, CurrentBoardState, TmpNextStepBoardState),
			NextRowIndex = CurrentRowIndex - 1,
			get_next_step_board_rows(NextRowIndex, ColumnCount, TmpNextStepBoardState, NextStepBoardState),
			!.
	                                                                                              
	% перебрать все колонки текущей строки матрицы текущего состояния, чтобы отметить возможные варианты следующего хода
	get_next_step_board_columns(_, -1, CurrentBoardState, CurrentBoardState):-
			!.
			
	get_next_step_board_columns(CurrentRowIndex, CurrentColumnIndex, CurrentBoardState, NextStepBoardState):-
			set_next_step_star_center(CurrentRowIndex, CurrentColumnIndex, CurrentBoardState, TmpNextStepBoardState),
			NextColumnIndex = CurrentColumnIndex - 1,
			get_next_step_board_columns(CurrentRowIndex, NextColumnIndex, TmpNextStepBoardState, NextStepBoardState),
			!.

	% установить в текущую координату центр расходяшейся звезды следующих шагов
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
	             
	% установить в текущую координату "элемент" луча расходяшейся звезды следующих шагов
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
   
   % оценить эффективность каждого возможного хода
   get_marked_board(square(BoardSize, NextStepBoard), MarkedNextStepBoard):-
		mark_func(NextStepBoard, 0, NextStepBoard, TmpMarkedNextStepBoard),
		copy_square(square(BoardSize, TmpMarkedNextStepBoard), MarkedNextStepBoard),
		!.
 
   % Расчет оценки для всей матрицы, начиная со строки RowNumber
   mark_func(E, RowNumber, StartMarkMatrix, NewMarkMatrix):-
   		mark_row(E, RowNumber, 0, StartMarkMatrix, NewMarkMatrix1),	% Расчитываем для неё оценки
   		RowNumber1 = RowNumber + 1,					% берем следующую строку
   		mark_func(E, RowNumber1, NewMarkMatrix1, ResM),			% то считаем дальше
   		copy_matrix(ResM, NewMarkMatrix),
        !.	
   
   % для случая с выходом за пределы
   mark_func(E, RowNumber, StartMarkMatrix, NewMarkMatrix):-
   		get_matrix_row_count(E, RowCount),				% считаем число строк
   		RowNumber >= RowCount,
   		copy_matrix(StartMarkMatrix, NewMarkMatrix),
   		!.
   
   % Расчет оценок для одной строки
   mark_row(E, RowNumber, ColNumber, StartMarkMatrix, NewMarkMatrix):-
   		mark_element(E, RowNumber, ColNumber, ResElem),			% расчитываем оценку
   		set_matrix_element(StartMarkMatrix, RowNumber, ColNumber, ResElem, NewMarkMatrix1),	% Записываем результат в матрицу 
   		ColNumber1 = ColNumber + 1,					% двигаемся дальше
   		mark_row(E, RowNumber, ColNumber1, NewMarkMatrix1, NewMarkMatrix),
        !.	% считаем дальше		
   
   % Выход за пределы
   mark_row(E, RowNumber, ColNumber, StartMarkMatrix, NewMarkMatrix):-
   		get_matrix_row(E, RowNumber, Row), 				% берем строку
   		get_list_size(Row,Len),						% считаем число столбцов
   		ColNumber >= Len,
   		copy_matrix(StartMarkMatrix, NewMarkMatrix),
   		!.
   
   % Расчет оценки ячейки
   mark_element(E, RowNumber, ColNumber, Mark):-
   		get_matrix_row(E, RowNumber, Row), 				% Берем строку
   		get_list_element(Row, ColNumber, Elem),				% берем ячейку
   		Elem = -3,							% если разрешенная ячейка
   		find_left(E, RowNumber, ColNumber, 0, 0, MarkFriend, MarkEnemy),	% Считаем вокруг
   		Mark1 = 1 + MarkFriend + MarkEnemy,					% суммируем
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

   % если запрещен расчет в ячейке		
   mark_element(E, RowNumber, ColNumber, 0):-
   		get_matrix_row(E, RowNumber, Row), 				% Берем строку
   		get_list_element(Row, ColNumber, Elem),				% берем ячейку
   		Elem = 0,
        !.							% запрещена
   		
   % если запрещен ход в ячейку		
   mark_element(E, RowNumber, ColNumber, -4):-
   		get_matrix_row(E, RowNumber, Row), 				% Берем строку
   		get_list_element(Row, ColNumber, Elem),				% берем ячейку
   		Elem = -4,
        !.							% запрещена
   
   % если ячейка уже занята своими		
   mark_element(E, RowNumber, ColNumber, -1):-
   		get_matrix_row(E, RowNumber, Row), 				% Берем строку
   		get_list_element(Row, ColNumber, Elem),				% берем ячейку
   		Elem = -1,
        !.							% занята своими
   
   % если ячейка уже занята чужими
   mark_element(E, RowNumber, ColNumber, -2):-
   		get_matrix_row(E, RowNumber, Row), 				% Берем строку
   		get_list_element(Row, ColNumber, Elem),				% берем ячейку
   		Elem = -2,
        !.							% занята чужими		
   
   % Проверка на смену цвета в ряду		
   is_not_changed(_, StartMarkEnemy, -1):-
   		StartMarkEnemy = 0,
        !.
   
   is_not_changed(StartMarkFriend, _, -2):-
   		StartMarkFriend = 0,
        !.
      
   % Суммирование очков слева
   find_left(E, RowNumber, ColNumber, StartMarkFriend, StartMarkEnemy, NewMarkFriend, NewMarkEnemy):-
   		Col = ColNumber - 1,								% двигаемся влево
   		Col >= 0,									% если не вышли за пределы
   		get_matrix_element(E,RowNumber,Col,Elem),					% читаем элемент
   		not (Elem = -3),
   		is_not_changed(StartMarkFriend, StartMarkEnemy, Elem),
   		add_mark_for_element(Elem, StartMarkFriend, StartMarkEnemy, AddMarkFriend, AddMarkEnemy),% получаем добавочные очки
   		NewMarkFriend1 = StartMarkFriend + AddMarkFriend,				% суммируем
   		NewMarkEnemy1 = StartMarkEnemy + AddMarkEnemy,
   		find_left(E,RowNumber,Col,NewMarkFriend1,NewMarkEnemy1,ResMarkFriend, ResMarkEnemy),% двигаемся дальше
   		NewMarkFriend = ResMarkFriend,
   		NewMarkEnemy = ResMarkEnemy,
        !.
      
   % если сменился цвет
   find_left(E, RowNumber, ColNumber, StartMarkFriend, StartMarkEnemy, StartMarkFriend, StartMarkEnemy):-
   		Col = ColNumber - 1,								% двигаемся влево
   		Col >= 0,									% если не вышли за пределы
   		get_matrix_element(E,RowNumber,Col,Elem),					% читаем элемент
   		not (Elem = -3),
   		not (is_not_changed(StartMarkFriend, StartMarkEnemy, Elem)),
   		!.
   
   % если вышли за пределы
   find_left(_, _, ColNumber, StartMarkFriend, StartMarkEnemy, NewMarkFriend, NewMarkEnemy):-
   		Col = ColNumber - 1,								% двигаемся влево
   		Col < 0,
   		NewMarkFriend = StartMarkFriend,
   		NewMarkEnemy = StartMarkEnemy,
   		!.
	
   % если снова свободная клетка	
   find_left(E, RowNumber, ColNumber, StartMarkFriend, StartMarkEnemy, StartMarkFriend, StartMarkEnemy):-
   		Col = ColNumber - 1,
   		Col >= 0,									% если не вышли за пределы
   		get_matrix_element(E,RowNumber,Col,Elem),
   		Elem = -3,
   		!.
   
   % Суммирование очков справа
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
   
   % Суммирование очков сверху		
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
   
   % Суммирование очков снизу		
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
   
   % Суммирование очков слева-сверху		
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
   
   % Суммирование очков справа-сверху
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
   
   % Суммирование очков справа-снизу		
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
   
   % Суммирование очков слeва-снизу		
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
   
   % система оценок
   
   % Когда запрещен расчет		
   add_mark_for_element(0, _, _, AddMarkFriend,AddMarkEnemy):-
   		AddMarkFriend = 0,					% ничего и не добавляем
   		AddMarkEnemy = 0,
   		!.
   
   % если дальше пустая ячейка		
   add_mark_for_element(-3, _, _, AddMarkFriend,AddMarkEnemy):-
   		AddMarkFriend = 0,					% ничего и не добавляем
   		AddMarkEnemy = 0,
   		!.
   
   % Когда есть своя фишка		
   add_mark_for_element(-1, 0, MarkEnemy, AddMarkFriend, AddMarkEnemy):-
   		MarkEnemy <= 0,						% если не было до этого вражеских в линии
   		AddMarkFriend = 1,				
   		AddMarkEnemy = 0,
        !.
   
   % две подряд
   add_mark_for_element(-1, 1, MarkEnemy, 2, 0):-
   		MarkEnemy <= 0,						% если не было до этого вражеских в линии
        !.
   
   % три в ряд                     
   add_mark_for_element(-1, 3, MarkEnemy, 3, 0):-
   		MarkEnemy <= 0,						% если не было до этого вражеских в линии
        !.
                        
   % четыре в ряд
   add_mark_for_element(-1, 6, MarkEnemy, 7, 0):-
   		MarkEnemy <= 0,						% если не было до этого вражеских в линии
        !.
                        
   add_mark_for_element(-1, MarkFriend, MarkEnemy, 1, 0):- 
   		MarkEnemy <= 0,					
   		MarkFriend > 13,				
        !.
   
   % Когда у врага 1		
   add_mark_for_element(-2, MarkFriend, 0, AddMarkFriend, AddMarkEnemy):-
   		MarkFriend <= 0,					% если не было своих в линии и при этом уже было две вражеских, то ппц уже
   		AddMarkEnemy = 1,					
   		AddMarkFriend = 0,
        !.
   
   % Когда у врага кобинация из 2		
   add_mark_for_element(-2, MarkFriend, 1, AddMarkFriend, AddMarkEnemy):-
   		MarkFriend <= 0,					% если не было своих в линии и при этом уже было две вражеских, то ппц уже
   		AddMarkEnemy = 2,					
   		AddMarkFriend = 0,
        !.
                       
   % Когда у врага кобинация из 3		
   add_mark_for_element(-2, MarkFriend, 3, AddMarkFriend, AddMarkEnemy):-
   		MarkFriend <= 0,					% если не было своих в линии и при этом уже было две вражеских, то ппц уже
   		AddMarkEnemy = 4,				
   		AddMarkFriend = 0,
        !.
    
   % Когда у врага кобинация из 4		
   add_mark_for_element(-2, MarkFriend, 7, AddMarkFriend, AddMarkEnemy):-
   		MarkFriend <= 0,					% если не было своих в линии и при этом уже было две вражеских, то ппц уже
   		AddMarkEnemy = 5,					
   		AddMarkFriend = 0,
        !.
    
   
   add_mark_for_element(-2, MarkFriend, MarkEnemy, 0, 1):- 
   		MarkFriend <= 0,					% если не было жо этого в линии своих
   		MarkEnemy > 12,						% и при этом не набрано еще две вражеских в линию
        !.									                          
            
                        
   add_mark_for_element(_, _, _, 0, 0):-
   		!.					
   

% <\Marc Next Step Board ********************************************************************************************************************>  

% <Arbitrator ************************************************************************************************************************************>

   % проверить возможные ходы на фолы
   get_checked_next_step_board(square(BoardSize, NextStepBoardState), CheckedNextStepBoardState):-
		check_func(NextStepBoardState, 0, NextStepBoardState, TmpCheckedNextStepBoard),
		copy_square(square(BoardSize, TmpCheckedNextStepBoard), CheckedNextStepBoardState),
		!.
 
   % для случая с выходом за пределы
   check_func(E, RowNumber, StartMatrix, NewMatrix):-
   		get_matrix_row_count(E, RowCount),			
   		RowNumber >= RowCount,
   		copy_matrix(StartMatrix, NewMatrix),
   		!.
 
   % Расчет фолов для всей матрицы, начиная со строки RowNumber
   check_func(E, RowNumber, StartMatrix, NewMatrix):-
   		check_row(E, RowNumber, 0, StartMatrix, NewMatrix1),
   		RowNumber1 = RowNumber + 1,					
   		check_func(E, RowNumber1, NewMatrix1, ResM),			
   		copy_matrix(ResM, NewMatrix),
        !.	
   
   % Выход за пределы
   check_row(E, RowNumber, ColNumber, StartMatrix, NewMatrix):-
   		get_matrix_row(E, RowNumber, Row), 				
   		get_list_size(Row,Len),						
   		ColNumber >= Len,
   		copy_matrix(StartMatrix, NewMatrix),
   		!.
   
   % Расчет фолов для одной строки
   check_row(E, RowNumber, ColNumber, StartMatrix, NewMatrix):-
   		check_element(E, RowNumber, ColNumber, ResElem),			
   		set_matrix_element(StartMatrix, RowNumber, ColNumber, ResElem, NewMatrix1),	
   		ColNumber1 = ColNumber + 1,					
   		check_row(E, RowNumber, ColNumber1, NewMatrix1, NewMatrix),
        !.		
   
   
   % отсеиваем все несвободные и запрещенные
   check_element(E, RowNumber, ColNumber, CheckState):-
   		get_matrix_row(E, RowNumber, Row), 				
   		get_list_element(Row, ColNumber, Elem),
   		Elem <> -3,
   		CheckState = Elem,
   		!.
   
   % вилка 3х3
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
   
   % если точно не 3х3, и при этом нет предпосылок 4х4
   check_element(E, RowNumber, ColNumber, CheckState):-
   		get_matrix_row(E, RowNumber, Row), 				
   		get_list_element(Row, ColNumber, Elem),			
   		Elem = -3,							
   		find_left(E, RowNumber, ColNumber, 0, 0, CheckFriend1, _),
   		CheckFriend1 <> 1,
   		CheckFriend1 <> 3,			
   		CheckState = Elem,
   		!. 
   
   % вилка 4х4 справа и наверх		
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
   
   % точно не 4х4 (нет справа, но и нет слева)		
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
   		
   % не 4х4 (нет сверху, но и нет снизу)		
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
   		
   % не 4х4 (нет сверху, нет слева, но и нет справа)		
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
   		
   % не 4х4 (нет снизу, нет слева, но и нет справа)	 	
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
   		
   % не 4х4 (нет слева, нет сверху, но и нет снизу)		
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
   		
   % не 4х4 (нет справа, нет сверху, но и нет снизу)		
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
   		
   % 4х4 (слева наверх)		
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
   		
   % 4х4 (слева вниз)		
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
   		
   % 4х4 (справа вниз)		
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
   
   % проверка окончания игры      	
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
   % выполнить главную процедуру Рендзю
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
   % получить координаты хода компьютерного противника (компьютер играет черными камнями)
   execute_renju_ai_is_black(CurrentBoardStateMatrix, NextStepRowIndex, NextStepColumnIndex):-
		fill_square(CurrentBoardStateMatrix,CurrentBoardState),
		get_next_step_board(CurrentBoardState, NextStepBoardState),
		get_checked_next_step_board(NextStepBoardState,CheckedNextStepBoardState),
		get_marked_board(CheckedNextStepBoardState, MarkedNextStepBoardState),
		get_square_max_coordinates(MarkedNextStepBoardState, NextStepRowIndex, NextStepColumnIndex),
		!.
                                                                                                  
   
   % получить координаты хода компьютерного противника (компьютер играет белыми камнями)
   execute_renju_ai_is_white(CurrentBoardStateMatrix, NextStepRowIndex, NextStepColumnIndex):-
		fill_square(CurrentBoardStateMatrix,CurrentBoardState),
		get_next_step_board(CurrentBoardState, NextStepBoardState),
		get_marked_board(NextStepBoardState, MarkedNextStepBoardState),
		get_square_max_coordinates(MarkedNextStepBoardState, NextStepRowIndex, NextStepColumnIndex),
		!.   			
                            
   get_matrix_from_square(square(_,Matrix),AufMatrix):-
		copy_matrix(Matrix,AufMatrix),
		!.

   % получить координаты хода компьютерного противника (компьютер играет черными камнями) [ОТЛАДОЧНАЯ ВЕРСИЯ]
   execute_renju_ai_is_black_debug(CurrentBoardStateMatrix, ComputedBoardStateMatrix, NextStepRowIndex, NextStepColumnIndex):-
		fill_square(CurrentBoardStateMatrix,CurrentBoardState),
		get_next_step_board(CurrentBoardState, NextStepBoardState),
		get_checked_next_step_board(NextStepBoardState,CheckedNextStepBoardState),
		get_marked_board(CheckedNextStepBoardState, ComputedBoardState),
		get_matrix_from_square(ComputedBoardState,ComputedBoardStateMatrix),
		get_square_max_coordinates(ComputedBoardState, NextStepRowIndex, NextStepColumnIndex),
		!.
   
   % получить координаты хода компьютерного противника (компьютер играет белыми камнями) [ОТЛАДОЧНАЯ ВЕРСИЯ]
   execute_renju_ai_is_white_debug(CurrentBoardStateMatrix, ComputedBoardStateMatrix, NextStepRowIndex, NextStepColumnIndex):-
		fill_square(CurrentBoardStateMatrix,CurrentBoardState),
		get_next_step_board(CurrentBoardState, NextStepBoardState),
		get_marked_board(NextStepBoardState, ComputedBoardState),
		get_matrix_from_square(ComputedBoardState,ComputedBoardStateMatrix),
		get_square_max_coordinates(ComputedBoardState, NextStepRowIndex, NextStepColumnIndex),
		!.
   
   % получить координаты фолов черных для игрока-человека
   execute_renju_human_is_black(CurrentBoardStateMatrix, RestrictedBoardStateMatrix):-
		fill_square(CurrentBoardStateMatrix,CurrentBoardState),
		change_all_square_value1_to_value2(CurrentBoardState, 0, -3, TmpCurrentBoardState),
		get_checked_next_step_board(TmpCurrentBoardState, RestrictedBoardState),
		get_matrix_from_square(RestrictedBoardState,RestrictedBoardStateMatrix),
	!.
                        		
   % проверить, закончена ли игра                     						  
   execute_renju_check_the_game_end(CurrentBoardStateMatrix, Result):-
		test_func(CurrentBoardStateMatrix,0,Result),!.
% <	Execute Renju ************************************************************************************************************************************>   

% <	Exported procedures ****************************************************************************************************************************************>    
   % получить координаты хода компьютерного противника (компьютер играет черными камнями)
   export_execute_renju_ai_is_black(CurrentBoardStateList, NextStepRowIndex, NextStepColumnIndex):-
		convert_list_to_matrix(CurrentBoardStateList, CurrentBoardStateMatrix),
		execute_renju_ai_is_black(CurrentBoardStateMatrix, NextStepRowIndex, NextStepColumnIndex),
		!.

   % получить координаты хода компьютерного противника (компьютер играет белыми камнями)
   export_execute_renju_ai_is_white(CurrentBoardStateList, NextStepRowIndex, NextStepColumnIndex):-
		convert_list_to_matrix(CurrentBoardStateList, CurrentBoardStateMatrix),
		execute_renju_ai_is_white(CurrentBoardStateMatrix, NextStepRowIndex, NextStepColumnIndex),
		!.

   % получить координаты хода компьютерного противника (компьютер играет черными камнями) [ОТЛАДОЧНАЯ ВЕРСИЯ]
   export_execute_renju_ai_is_black_debug(CurrentBoardStateList, ComputedBoardStateList, NextStepRowIndex, NextStepColumnIndex):-
		convert_list_to_matrix(CurrentBoardStateList, CurrentBoardStateMatrix),
		execute_renju_ai_is_black_debug(CurrentBoardStateMatrix, ComputedBoardStateMatrix, NextStepRowIndex, NextStepColumnIndex),
		convert_matrix_to_list(ComputedBoardStateMatrix, ComputedBoardStateList),
		!.
   
   % получить координаты хода компьютерного противника (компьютер играет белыми камнями) [ОТЛАДОЧНАЯ ВЕРСИЯ]
   export_execute_renju_ai_is_white_debug(CurrentBoardStateList, ComputedBoardStateList, NextStepRowIndex, NextStepColumnIndex):-
		convert_list_to_matrix(CurrentBoardStateList, CurrentBoardStateMatrix),
		execute_renju_ai_is_white_debug(CurrentBoardStateMatrix, ComputedBoardStateMatrix, NextStepRowIndex, NextStepColumnIndex),
		convert_matrix_to_list(ComputedBoardStateMatrix, ComputedBoardStateList),
		!.

   % получить координаты фолов черных для игрока-человека
   export_execute_renju_human_is_black(CurrentBoardStateList, RestrictedBoardStateList):-
		convert_list_to_matrix(CurrentBoardStateList, CurrentBoardStateMatrix),
		execute_renju_human_is_black(CurrentBoardStateMatrix, RestrictedBoardStateMatrix),
		convert_matrix_to_list(RestrictedBoardStateMatrix, RestrictedBoardStateList),
		!.
   
   % проверить, кончилась ли игра
   export_execute_renju_check_the_game_end(CurrentBoardStateList, Result):-
		convert_list_to_matrix(CurrentBoardStateList, CurrentBoardStateMatrix),
		execute_renju_check_the_game_end(CurrentBoardStateMatrix, Result),
		!.
                        						  
   % тестирование экспорта int-а
   export_execute_test_export_int(IntIn, IntOut):-
		IntOut = IntIn + 10,
		!.      
   % тестирование экспорта list-а                              
   export_execute_test_export_list([_|T], IntOut):-
		IntOut = T,
		!.

% <   \Exported procedures ****************************************************************************************************************************************>                                                                

% <\Renju ****************************************************************************************************************************************>
/*
% <Test ******************************************************************************************************************************************>
   
   % тестировть главную функцию Рендзю
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