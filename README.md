# BandTech





This is a simple Flutter product listing application built using the public Fake Store API. The app fetches products from https://fakestoreapi.com/products, displays them in a clean responsive grid, allows users to search products by name, view full product details, and save products as favorites locally.

# Technologies Used

- Flutter: Used to build the mobile application UI.
- Dart: Main programming language.
- Fake Store API: Used as the public product data source.
- Dio: Used for API/network requests.
- Riverpod: Used for state management.
- shared_preferences: Used for local favorites storage.
- flutter_screenutil: Used for responsive UI sizing across different screen sizes.
- Material Design: Used for app UI components.
- ThemeData / DarkTheme: Used for light and dark mode support.
- Android Internet Permission: Added to allow API calls on Android devices.
- System Architructure: Used Mvvm patterns.

# Key Features

- Fetch and display products from Fake Store API.
- Product cards show image, title, price, and rating.
- Search bar filters products by product name.
- Loading indicator while fetching products.
- Error state for failed requests or no internet.
- Retry button for failed API calls.
- Product detail screen with full product information.
- Add and remove products from favorites.
- Favorites are saved locally using shared_preferences.
- Separate Favorites screen for saved products.
- SnackBar feedback for favorite actions.
- Responsive UI using flutter_screenutil.
- Dark mode support based on phone system theme.
- Smooth fade transition between home and product detail screen.
- MVVM with Repository Pattern

# screen recording
https://www.loom.com/share/0d58621532d44a90820fa4f072bfd660

# screenshots

<div style="display:flex; gap:20px;">
  <img width="30%" alt="Screenshot_20260520_112918" src="https://github.com/user-attachments/assets/2dd6c99b-3d34-4183-adbd-88b4b8f1be28" />
  <img width="30%" alt="Screenshot_20260520_113231" src="https://github.com/user-attachments/assets/0ecb77ce-1b92-41ad-9c06-f24c57007397" />
  <img width="30%" alt="Screenshot_20260520_112731" src="https://github.com/user-attachments/assets/a73a5752-cd2c-45f1-831f-2e316a3c1588" />
</div>
<div style="display:flex; gap:20px;">
  <img width="30%" alt="Screenshot_20260520_112951" src="https://github.com/user-attachments/assets/25604846-7a76-4d9e-8026-234965bccffb" />
  <img width="30%" alt="Screenshot_20260520_111651" src="https://github.com/user-attachments/assets/048320a5-4175-4ca7-afcd-37ce9db9fdcc" />
  <img width="30%" alt="Screenshot_20260520_113126" src="https://github.com/user-attachments/assets/6bae818e-14be-4a9a-9b5d-ef925b7f2be7" />
 </div>














