# «Мобильное приложение "Friend Finder"» 
## Описание приложения
Приложение для платформ `iOS` и `Android`, разработанное на языке программирования `Dart` с использованием фреймворка `Flutter` предназначено для организации встреч с другими пользователями на карте местности.
Мобильное приложение позволит пользователям создавать личные аккаунты и взаимодействовать с картой местности. Основной функционал включает в себя возможность создания "событий" на карте, описывающих планируемую деятельность или мероприятие, а также возможность откликаться на события других пользователей.
Основные функции:
- Регистрация пользователей: приложение обеспечивает удобный процесс регистрации пользователей, позволяя им легко войти в систему.
- Возможность создания "событий": приложение предоставляет возможность создавать на карте "события", описывающие планируемую деятельность или мероприятие.
- Просмотр событий: пользователи имеют возможность просматривать события, созданные другими пользователями, а также удалять собственные.

## Приложение
### Структура
Язык программирования: Dart  
База данных: Firebase  
Среда разработки: Android Studio 
### Регистрация и вход
Для входа в личный кабинет пользователю необходимо сначала пройти регистрацию. Необходимо ввести свой адрес электронной почты, а также придумать логин и пароль.  

Экран регистрации:  
![Первый скриншот](https://github.com/QuaRaion/FriendFinder/blob/main/screens/img_2.jpg)

В случае, если пользователь уже зарегистрирован, ему необходимо войти в свой аккаунт.

Экран входа:
![Второй скриншот](https://github.com/QuaRaion/FriendFinder/blob/main/screens/img_1.jpg)
### Взаимодействие с картой
После успешного входа в личный кабинет пользователь будет направлен на карту, где у него есть возможность, нажав на стрелку в левом нижнем углу, перейти к своему расположению на карте, нажавна кнопку в правом углу пользователь сможет просмотреть свой профиль. Также на карте есть возможность добавить событие путем удержания точки, в которую вы хотите его установить. 

Карта:  
![Третий скриншот](https://github.com/QuaRaion/FriendFinder/blob/main/screens/img_3.jpg)  
Экран создания события:  
![Четвертый скриншот](https://github.com/QuaRaion/FriendFinder/blob/main/screens/img_5.jpg)  
 
### Личный кабинет
После нажатия на аватар в правом нижнем углу карты пользователь попадет в личный кабинет. В личном кабинете отображается информация об имени пользователя, есть возможность просмотра друзей и событий, созднанных пользователем, а также есть возможность перехода в настройки. Во вкладке "Мои события", помимо просмотра всех созданных пользователем событий, также присутствует возможность их удаления. Вернуться на карту можно с помощью кнопки, расположенной в левой нижней части экрана.

Экран личного кабинета пользователя:
![Пятый скриншот](https://github.com/QuaRaion/FriendFinder/blob/main/screens/img_4.jpg)      
Экран просмотра друзей пользователя: 
![Шестой скриншот](https://github.com/QuaRaion/FriendFinder/blob/main/screens/img_9.jpg) 
Экран просмотра событий пользователя:
![Седьмой скриншот](https://github.com/QuaRaion/FriendFinder/blob/main/screens/img_7.jpg)    
Экран настроек:  
![Восьмой скриншот](https://github.com/QuaRaion/FriendFinder/blob/main/screens/img_8.jpg)  

## Пользование приложением
### Инструкция по запуску приложения
Скачивание приложения:    
1. Нажмите на зелёную кнопку "Code" и выберите "Download ZIP".  
2. Разархивируйте скачанный ZIP-файл в удобную для вас директорию на компьютере.
3. Запустите Android Studio и в главном меню Android Studio выберите "File" -> "Open".
4. Обновите все зависимости, нажав на кнопку "Get Dependencies"
5. Перейдите в папку с клонированным или распакованным проектом и выберите его.
6. Если вы используете эмулятор, убедитесь, что он настроен и запущен. Это можно сделать через "AVD Manager" в Android Studio. Если вы используете реальное устройство, подключите его к компьютеру через USB и убедитесь, что на нем включена отладка по USB.
7. Нажмите зеленую кнопку "Run" в верхней части Android Studio или выберите "Run" -> "Run 'app'".
8. Выберите устройство (эмулятор или реальное) и нажмите "OK".
9. После запуска приложение откроется на выбранном устройстве (эмуляторе или реальном устройстве).
10. Для начала работы войдите в личный кабинет.

## Проект выполняют студенты группы 4217:
Махкамов Шерзод
Мазориев Умар
Мостовой Александр
