import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                
                // Logo veya başlık
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[100],
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Icon(
                    Icons.person_add,
                    size: 40,
                    color: Colors.deepPurple,
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Başlık
                Text(
                  'Hesap Oluştur',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 8),
                
                Text(
                  'SkinMate\'e katılmak için bilgilerinizi girin',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 40),
                
                // İsim alanı
                _buildTextField(
                  controller: _nameController,
                  label: 'Ad Soyad',
                  icon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen adınızı girin';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 16),
                
                // Email alanı
                _buildTextField(
                  controller: _emailController,
                  label: 'E-posta',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen e-posta adresinizi girin';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Geçerli bir e-posta adresi girin';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 16),
                
                // Telefon alanı
                _buildTextField(
                  controller: _phoneController,
                  label: 'Telefon Numarası',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen telefon numaranızı girin';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 16),
                
                // Şifre alanı
                _buildTextField(
                  controller: _passwordController,
                  label: 'Şifre',
                  icon: Icons.lock_outline,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen şifrenizi girin';
                    }
                    if (value.length < 6) {
                      return 'Şifre en az 6 karakter olmalı';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 16),
                
                // Şifre tekrar alanı
                _buildTextField(
                  controller: _confirmPasswordController,
                  label: 'Şifre Tekrar',
                  icon: Icons.lock_outline,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen şifrenizi tekrar girin';
                    }
                    if (value != _passwordController.text) {
                      return 'Şifreler eşleşmiyor';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 32),
                
                // Kayıt ol butonu
                ElevatedButton(
                  onPressed: _handleSignUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: const Text(
                    'Hesap Oluştur',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Giriş yap linki
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Zaten hesabınız var mı? ',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    TextButton(
                      onPressed: () {
                        // Giriş sayfasına yönlendirme
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Giriş Yap',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? (isPassword == true ? _isPasswordVisible : _isConfirmPasswordVisible) ? false : true : false,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.deepPurple),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  (isPassword && controller == _passwordController) 
                      ? (_isPasswordVisible ? Icons.visibility_off : Icons.visibility)
                      : (_isConfirmPasswordVisible ? Icons.visibility_off : Icons.visibility),
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    if (controller == _passwordController) {
                      _isPasswordVisible = !_isPasswordVisible;
                    } else {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    }
                  });
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  void _handleSignUp() {
    if (_formKey.currentState!.validate()) {
      // Form geçerli, kayıt işlemi yapılabilir
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kayıt işlemi başarılı!'),
          backgroundColor: Colors.green,
        ),
      );
      
      // Burada gerçek kayıt işlemi yapılacak
      // Örnek: API çağrısı, veritabanına kaydetme vb.
    }
  }
}
