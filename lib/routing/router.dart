 
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grodudes/routing/route_paths.dart';

import '../Root.dart';
import '../components/CategoryCard.dart';
import '../models/Category.dart';
import '../models/Product.dart';
import '../pages/CartItems.dart';
import '../pages/HomeSpecialProductsPage.dart';
import '../pages/AllCategoriesPage.dart';
 import '../pages/SearchResultsPage.dart';
import '../pages/account/AccountRoot.dart';
import '../pages/account/AddressDetails.dart';
import '../pages/account/LogInPage.dart';
import '../pages/account/OrderDetails.dart';
import '../pages/account/Orders.dart';
import '../pages/account/profile_Details.dart';
import '../pages/checkout/AddressUpdatePage.dart';
import '../pages/checkout/ConfirmationPage.dart';
import '../pages/checkout/OrderPlacementPage.dart';
import '../pages/navigation.dart';
import '../pages/splash_screen.dart';
import '../pages/wishLsit.dart';

class AppRouter {


  static  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      
//         case RoutePaths.LogIn:
//         return MaterialPageRoute(builder: (_) => LogInScreen());
//       case RoutePaths.SignUp:
//         return MaterialPageRoute(builder: (_) => SignUpScreen());
//       case RoutePaths.HomeScreen:
//         return MaterialPageRoute(
//             builder: (_) => HomeScreen(
//                 settings.arguments as HomeScreenArgs));
//
      case RoutePaths.CategoryContents:
        return MaterialPageRoute(
            builder: (_) => CategoryContents(category:  settings.arguments as Category,
                
                ));
        case RoutePaths.SplashScreen:
        return MaterialPageRoute(
            builder: (_) => SplashScreen(

                ));
        case RoutePaths.SearchResultsPage:
        return MaterialPageRoute(
            builder: (_) => SearchResultsPage( settings.arguments as String

                ));
        case RoutePaths.HomeSpecialProductsPage:
        return MaterialPageRoute(
            builder: (_) => HomeSpecialProductsPage(
                settings.arguments as String, settings.arguments as Set<int>, settings.arguments as Future Function()

                ));
        case RoutePaths.Root:
        return MaterialPageRoute(
            builder: (_) => Root(

                ));
        case RoutePaths.AllCategoriesPage:
        return MaterialPageRoute(
            builder: (_) => AllCategoriesPage(

                ));
        case RoutePaths.ConfirmationPage:
        return MaterialPageRoute(
            builder: (_) => ConfirmationPage(

                ));

        case RoutePaths.ProfileDetails:
        return MaterialPageRoute(
            builder: (_) => ProfileDetails(title: settings.arguments as String,
              type:settings.arguments as String,
              updateCb: settings.arguments as Future<String> Function(Map<String, dynamic>),

                ));
        case RoutePaths.Orders:
        return MaterialPageRoute(
            builder: (_) => Orders(
            ));
        case RoutePaths.AddressDetails:
        return MaterialPageRoute(
            builder: (_) => AddressDetails(title: settings.arguments as String,
              type:settings.arguments as String,
              updateCb: settings.arguments as Future<String> Function(List<Map<String, dynamic>>),

            ));
        case RoutePaths.NavigationScreen:
        return MaterialPageRoute(
            builder: (_) => NavigationScreen(


            ));
        case RoutePaths.LoginPage:
        return MaterialPageRoute(
            builder: (_) => LoginPage(


            ));
        case RoutePaths.OrderDetails:
        return MaterialPageRoute(
            builder: (_) => OrderDetails(  settings.arguments as Map<String, dynamic>
            ));
        case RoutePaths.AccountRoot:
        return MaterialPageRoute(
            builder: (_) => AccountRoot(
             ));
        case RoutePaths.AddressUpdatePage:
        return MaterialPageRoute(
            builder: (_) => AddressUpdatePage(
              address:  settings.arguments as Map<String, dynamic>  ,
              updateCb: settings.arguments as Function,
               shouldDisplayPostcodeDropdown:
               settings.arguments as bool?,
             ));
        case RoutePaths.OrderPlacementPage:
        return MaterialPageRoute(
            builder: (_) => OrderPlacementPage(

              customerId: settings.arguments as int  ,
              shippingAddress:  settings.arguments as Map<String, dynamic>,
              billingAddress:     settings.arguments as Map<String, dynamic>,
                items: settings.arguments as List<Product>,
             ));
        case RoutePaths.Wishtems:
        return MaterialPageRoute(
            builder: (_) => Wishtems(

             
             ));
        case RoutePaths.CartItems:
        return MaterialPageRoute(
            builder: (_) => CartItems(


             ));
//
//       case RoutePaths.wizardRegisterFirstStep:
//         return MaterialPageRoute(builder: (_) => WizardRegisterFirstStep(
//             registerDocArg: settings.arguments as RegisterDocArg
//         ));
//       case RoutePaths.wizardRegisterSecondeStep:
//         return MaterialPageRoute(builder: (_) => WizardRegisterSecondeStep(
//            registerDocArg: settings.arguments as RegisterDocArg
//         ));
//       case RoutePaths.firstDocFirstStep:
//         return MaterialPageRoute(builder: (_) => FirstDocFirstStep(
//           firstDocDocArg: settings.arguments as FirstDocDocArg,
//         ));
//       case RoutePaths.firstDocSecondStep:
//         return MaterialPageRoute(builder: (_) => FirstDocSecondStep(
//           firstDocDocArg: settings.arguments as FirstDocDocArg,
//
//         ));
//       case RoutePaths.firstDocThirdStep:
//         return MaterialPageRoute(builder: (_) => FirstDocThirdStep(
//           firstDocDocArg: settings.arguments as FirstDocDocArg,
//
//         ));
//       case RoutePaths.firstDocForthStep:
//         return MaterialPageRoute(builder: (_) => FirstDocForthStep(
//           firstDocDocArg: settings.arguments as FirstDocDocArg,
//         ));
//       case RoutePaths.secondDocFirstStep:
//         return MaterialPageRoute(builder: (_) => SecondDocFirstStep(
//           secondeDocDocArg:settings.arguments as  SecondeDocDocArg,
//         ));
//       case RoutePaths.secondDocSecondStep:
//         return MaterialPageRoute(builder: (_) => SecondDocSecondStep(
//           secondeDocDocArg:settings.arguments as  SecondeDocDocArg,
//
//         ));
//       case RoutePaths.secondDocThirdStep:
//         return MaterialPageRoute(builder: (_) => SecondDocThirdStep(
//           secondeDocDocArg:settings.arguments as  SecondeDocDocArg,
//
//         ));
//       case RoutePaths.secondDocForthStep:
//         return MaterialPageRoute(builder: (_) => SecondDocForthStep(
//           secondeDocDocArg:settings.arguments as  SecondeDocDocArg,
//
//         ));
//       case RoutePaths.thirdDocFirstStep:
//         return MaterialPageRoute(builder: (_) => ThirdDocFirstStep(
//           thirdDocDocArg:  settings.arguments as ThirdDocDocArg,
//           patienName: settings.arguments as String,serviceName: settings.arguments as String,
//         ));
//       case RoutePaths.thirdDocSecondStep:
//         return MaterialPageRoute(builder: (_) => ThirdDocSecondStep(
//           thirdDocDocArg:  settings.arguments as ThirdDocDocArg,
//           patienName: settings.arguments as String,serviceName: settings.arguments as String,
//
//         ));
//       case RoutePaths.thirdDocThirdStep:
//         return MaterialPageRoute(builder: (_) => ThirdDocThirdStep(
//           thirdDocDocArg:  settings.arguments as ThirdDocDocArg,
//           patienName: settings.arguments as String,serviceName: settings.arguments as String,
//
//         ));
//       case RoutePaths.attachementPage:
//         return MaterialPageRoute(builder: (_) => AttachmentPage(
//           appointmentData:  settings.arguments as GetAppointmentDataContent,
//           register:settings.arguments as bool,
//
//         ));
//       case RoutePaths.forthDocFirstStep:
//         return MaterialPageRoute(builder: (_) => ForthDocFirstStep());
//       case RoutePaths.forthDocSecondStep:
//         return MaterialPageRoute(builder: (_) => ForthDocSecondStep());
//       case RoutePaths.fifthDocFirstStep:
//         return MaterialPageRoute(builder: (_) => FifthDocFirstStep(
//           thirdDocDocArg:  settings.arguments as ThirdDocDocArg,
//
//         ));
//       case RoutePaths.fifthDocSecondStep:
//         return MaterialPageRoute(builder: (_) => FifthDocSecondStep(
//           thirdDocDocArg:  settings.arguments as ThirdDocDocArg,
//
//         ));
//       case RoutePaths.fifthDocThirdStep:
//         return MaterialPageRoute(builder: (_) => FifthDocThirdStep(
//           thirdDocDocArg:  settings.arguments as ThirdDocDocArg,
//
//         ));
//       case RoutePaths.homeScreenDoctor:
//         return MaterialPageRoute(builder: (_) => HomeScreenDoctor(
//
//         ));
//          case RoutePaths.appointmentDetailsDoc:
//         return MaterialPageRoute(builder: (_) => AppointmentDetailsDoc(
//           Id:  settings.arguments as int,));
//       case RoutePaths.patientProfilListCardTab:
//         return MaterialPageRoute(builder: (_) => PatientProfilListCardTab(
//           patientId:  settings.arguments as int,));
//       case RoutePaths.prescriptionPage:
//         return MaterialPageRoute(builder: (_) => PrescriptionPage(
//           appointmentId: settings.arguments as int,
//         ));
//       case RoutePaths.transferPage:
//         return MaterialPageRoute(builder: (_) => TransferPage(
//             appointmentId: settings.arguments as int));
//       case RoutePaths.attendancePage:
//         return MaterialPageRoute(builder: (_) => AttendancePage(
//             appointmentId: settings.arguments as int));
//       case RoutePaths.certificatePage:
//         return MaterialPageRoute(builder: (_) => CertificatePage(
//             appointmentId: settings.arguments as int));
//       case RoutePaths.appointmentScreenDocList:
//         return MaterialPageRoute(builder: (_) => AppointmentScreenDocList());
//       case RoutePaths.profileScreen:
//         return MaterialPageRoute(builder: (_) => ProfileScreen());
//       case RoutePaths.paitentProfil:
//         return MaterialPageRoute(builder: (_) => PatientProfil(
//           items: settings.arguments as GetAppointmentDataContent,));
//       case RoutePaths.appMainScreenDoc:
//         return MaterialPageRoute(builder: (_) => AppMainScreenDoc(
//
//           //  loginInfo:settings.arguments as HomeScreenArgs
//         ));
//       case RoutePaths.pdfViewWidget:
//         return MaterialPageRoute(builder: (_) => PDFViewWidget(
//           title: settings.arguments as String,
//         ));
//       case RoutePaths.editprofileScreen:
//         return MaterialPageRoute(builder: (_) => EditProfileScreen(
//           profile:  settings.arguments as ProfileContentModel,
//
//         ));
//       case RoutePaths.createAppointmentScreen:
//         return MaterialPageRoute(builder: (_) => CreateAppointmentScreen(
//           year: settings.arguments as int,
// hour:  settings.arguments as int,minute:settings.arguments as int ,
//           month: settings.arguments as int,day: settings.arguments as int,
//         ));
//       case RoutePaths.filterWidget:
//         return MaterialPageRoute(builder: (_) => FilterWidget(
//           doctorIds: settings.arguments as int,
//         ));
//       case RoutePaths.splashPage:
//         return MaterialPageRoute(builder: (_) => SplashScreen(
//           moduleId: settings.arguments as int,
//         ));
//        case RoutePaths.productScreenList:
//         return MaterialPageRoute(builder: (_) => ProductScreenList());
//         case RoutePaths.hTMLViewWidget:
//         return MaterialPageRoute(builder: (_) => HTMLViewWidget( url: settings.arguments as String,
//         count: settings.arguments as int,));
//       case RoutePaths.orderDetailsScreen:
//         return MaterialPageRoute(builder: (_) => OrderDetailsScreen(
//           id: settings.arguments as int,
//           supplier: settings.arguments as String,
//           orderNumber: settings.arguments as String,
//         ));
//       case RoutePaths.itemTabScreen:
//         return MaterialPageRoute(builder: (_) => ItemTabScreen(id: 0,));
//       case RoutePaths.itemListScreen:
//         return MaterialPageRoute(builder: (_) => ItemsListScreen());
//       case RoutePaths.checkinScreen:
//         return MaterialPageRoute(builder: (_) => CheckInScreen());
//       case RoutePaths.employeeListScreen:
//         return MaterialPageRoute(builder: (_) => EmployeeListScreen());
//
//         case RoutePaths.moduleSwitcherScreen:
//         return MaterialPageRoute(builder: (_) => ModuleSwitcherScreen());
//         case RoutePaths.erpMainScreen:
//         return MaterialPageRoute(builder: (_) =>ErpMainScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    // child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
