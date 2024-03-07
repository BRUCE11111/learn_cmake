#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --version         print cmake installer version
  --prefix=dir      directory in which to install
  --include-subdir  include the Tutorial-1.0.1-Linux subdirectory
  --exclude-subdir  exclude the Tutorial-1.0.1-Linux subdirectory
  --skip-license    accept license
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "Tutorial Installer Version: 1.0.1, Copyright (c) Humanity"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
LICENSE
=======

This is an installer created using CPack (https://cmake.org). No license provided.


____cpack__here_doc____
    echo
    while true
      do
        echo "Do you accept the license? [yn]: "
        read line leftover
        case ${line} in
          y* | Y*)
            cpack_license_accepted=TRUE
            break;;
          n* | N* | q* | Q* | e* | E*)
            echo "License not accepted. Exiting ..."
            exit 1;;
        esac
      done
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the Tutorial will be installed in:"
    echo "  \"${toplevel}/Tutorial-1.0.1-Linux\""
    echo "Do you want to include the subdirectory Tutorial-1.0.1-Linux?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/Tutorial-1.0.1-Linux"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

extractor="pax -r"
command -v pax > /dev/null 2> /dev/null || extractor="tar xf -"

tail $use_new_tail_syntax +155 "$0" | gunzip | (cd "${toplevel}" && ${extractor}) || cpack_echo_exit "Problem unpacking the Tutorial-1.0.1-Linux"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;
� �
�e �\}p�ߓ�ğ�����\�t���eY�H�Ĳ-�L��u��Y�N�@�t*6�3n�j�K�v�4����t�4��!�����͸��H�Nk�	�1��{�+߭&�L�iN��w�����[���P�N�
p��t�VW��WU׺���v"�&��]]�r9��*�Xge���l��4�P2!��Д��/6�ʉBB\(|i�9�n����|�X4�w\�2`}Ը���_UYI���r�`�׸j�뼚F��y�WT�����fOƅ C�h��ElB�P�?�cq�t�<��������D6�������{���m��wx����V. ж
8�=ۼ|��O7�W���%�8�y�{������
���D�g]��S"��OhIF�r�_����Ͽ�
��Nw��)?��.���_
Ē}a��'v��2�Zw�gm�Iׇ�B�k��!�r��U�6���A��á>��ﻺe\b�wWBP��P��������ܑW�jəq��ழ@/r�x��Z��� PN��!G�b��P�P�s�I~{��-�I�Ȁ; �c�@��y���B����{��nt�y�^��ߛ�+���\tz��P����;����� �чfr폍�3">/�R�@���He6h/;~޾�8ֿ��4Ss��;!z����v�2��>|���L����=�7&�t\��!�Ӳ5��lH�$Y�գk�E��gQ�B��]�ϊ1�O�'�~���J�Lm�MM�ز��dTL�n���2)�*v9N�õN�eT�E�@f�n�И	�Yq���x�0CE�ʂ�9�aìʁ�u��=bi*\d�-�0�{�\�9I�U��n5���l|��o����2�x,Q��:�ˀR�4�d��p��T�\B��������v~kK�6o7��il�� 8EŠ��g�:��v{(�V�>�������)y�O`�H�
gU���8����W� 9�a�C�D��Dp�%�)	,��Z4&
�g��h����I�`<6(��a��0�㾈�W�WL�~P+�=���)���+�RGދ��N�c]�3K1�"��'�D���(�K8�O�_�1��bA���~�6b}Z�c���+��F���i<�(@�?�Y
�������_w	}���7ig��� ����Ft�߉9��t�Q�z�)���)���b�Y���A������_rת���ng������5U��=��������G��M�:pd+�߫��~��c�'-ZN� +�+%cŉOB�z������9ZN(���J��������XR���2Z��Cu3^���뵼�ǠE�g�zXo�^����mf��Os�|Zo��y3�rR��Έ�OS^'��h��������ii�.\�Q;tZ��4#�S��]��C��P�P]My�ۑ�9\i��+���F��|����r?�������O���Ƀ�2 ˫�Q��(��/�����d�d��!�x����F�g��m:��ݡ�_�������#�����oO�����t���������{pOa�[O�_'��-�M|�>b��op����AI���~����4N(�qڹzL��l�F��,����jxܬcOR�33����K�7A��p��J��@�1N�[�g����n��b%}
�ߏ�O�za?��n[C�>1LOy�?�メ�/zP�I$Σ�D���BQ��I$|[w�B(!
�p,*t���P[�ge<���	L�GbQ�#����m[!E�dB���@E!�@8�#9��u�mmokl�]�C���"�3��ԟ�q"�"���O�4H?���}��Y��4hq����Ơ�K��N�p�=����\̪p�88��T8�7(�?Ǳ<=�9���}5�$�L2�$�>���ʸљn_�����}sB�H'��_��KN@�~�祵߁̾Z��w�?��$I��4#�O�4���,ݬ�ӻ�t�:]�N[��\�-n��lgw�X���5��
�ʬ��c���k?L�Dv�ew!�qN\
M�a�s�)��d�Q̡�:Y��f��]�R�ܑw7sG��
w�X38�P2ȑ���]D�7R���$7�p��/�S.uF,��տӹ����a��u5�g�U��l�.��}h�ٻ�����A#F����:�ȦW�ٔeA�M�(I����D�Z�)(q��S�G'`����Ix%����Rh��;�'��3K�9���re}��̪�'/��'�P1��W�^��S�W�����Z���Z�Է� I�Rk�a_�����}�~t=l��m�S�����nO�n�\���u�34��O`�`WW��ۿ=u�=�ns����o��Q�����?��u�.�=�]�{=���|������2�$�d�I&�d�I&�d�I&�w�VF�&��B<�Eٵ��@�I���M,�MF��x����/.��X�l>%���W�7�Yi������ޓ��'!����=�9����k8�$���I��?/Ih�Y���ԋU���"�!8 ��֚�K>ho#�_�B\�gb+j���i� gl^�i}խ7�|�G�S��D���Y��z��fym.��5y/,���x]o�,Zg�<��U^#l�=fi��~�굱cY^[٣��6�#�8[���V[C�V�9=��F�h+m�5�r�u-��o棿�$�L2�$�L2�$�L�_'���;�cb�{��d�'�}��q��o[��d��
��>�U��.J1ğƛ���b
�����Md����cNbP�-��p�x�H���X 2�#{ږ��k���Z�'1'Q|����V�ߒr�.���1i��R.N���?�i�(����>p��d��n�ॉ�W��	�p��T��j�.nM�;��Y`�.���Z|��&F�9�3F1�'t6����9]</ݿ�x~�j��@N+|:Y]�:uq;�����k���s�ŗ�n������x	8��/M�#Z���C�/���V�4��]�g�V��}�
�23�1F���8Uo6�OQ���q�P�\�
P�0_��<�"8�^*�aY>�>���nt���0����/_� ;3�ϋ��Ҍ�������8B�/2���gp>����ߙ�0�Q��}��g���e�3��rF�|=�w��я;x����a���2�q
��?���/��@������x�7�8�YF?N�e��G<���/�n����~�B�E�������	1:�`>�#�$PB����|a> ��	ޗ�Xd0,�B�Q笩��x_<�慨r�8HF"�PE��C4�"������q�|K����{�4�0�"
t$b��/@q�;�x:ښ�b$��uK��pv\s��;�Hƺ��WġD�44��*PȈI�zP�"��:����6<D����hc\��/��h��}�@�K��P C�ƶr���k�� p�����q��ה�M���W@A|6��nѩ�?�O��w"�͙~y�?�ϧ�<�^�h�sX�/�k^�@^�p��"��ԍ�<	�1� m��Q�!!:ƾ�ҧ�o��i����'~���i����!�}�ދq�f���W1��O���0d��;"P@�:������y!��we�C�Lxe���eE�ğ&���B�D�T���p2�����X���N8��,�:����*n��8���>�O�}��i��,�O���n?�?N����%�S��w�������W�>�'	/����{P�`�|�����k��Q��Q�oP�dDx����#?�)��k���r}�����]�O��C��hc���XV5~��H;>��!~�8v�:/Q�"�zGM�Nm9�>�F���O]�~1���������ӌޱҀ��pǾ.�9~�c�P��[��/�+~��
J�|ǊI&�t����x `  