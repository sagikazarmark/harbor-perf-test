# S3 environment failures

The test suite fails to complete in the S3 environment when VUs are set to 200.

(Tested with blob size left as default and set to `10MiB`. Setting the blob size to a larger amount works better with S3.)


## Steps to reproduce

1. Spin up the S3 environment
1. SSH into the test machine
1. Set the following environment variables:
    - `export HARBOR_VUS=200`
    - `export BLOB_SIZE=10MiB`
2. Follow the instructions in the readme to load test data and/or run the test suite


## Test output

The failing test is the `push-artifacts-to-same-projects`. The error rate varies, but it's usually somewhere between 50-80%.


```
...

INFO[0151] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-231, error: failed commit on ref "config-sha256:60a26b59c98922af3f61f612def75c1c76d5925dac9ab60da348ee3492739f63": unexpected status: 404 Not Found  source=console
INFO[0151] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-232, error: failed commit on ref "config-sha256:645a5c136df8077c250c1f31af43aaf891cb17c86cfbbfc63eeb87558b746348": unexpected status: 404 Not Found  source=console
INFO[0151] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-233, error: failed commit on ref "config-sha256:92bb010995e63050c41b8e90af3854d46d48b8ffc873d9a3d458721898917d05": unexpected status: 404 Not Found  source=console
INFO[0152] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-234, error: failed commit on ref "config-sha256:d79374d6dea13c90c89c4aa55852884aa5aaf3c5fe16e7b156003fe21fe855be": unexpected status: 404 Not Found  source=console
INFO[0152] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-235, error: failed commit on ref "config-sha256:aea9ba826368702fb5d5763b926ce864936e7bb2cc6f63e603f8d434d93a384c": unexpected status: 404 Not Found  source=console
INFO[0153] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-236, error: failed commit on ref "config-sha256:b1a9bf7ba5125c0150d2c727bd9d340de7b19ab2758839f2e79b5cfad629b8b2": unexpected status: 404 Not Found  source=console
INFO[0153] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-237, error: failed commit on ref "config-sha256:842a4723664986a641b4aeec727a950aa01db00b8271be36b46eb06f62e54c85": unexpected status: 404 Not Found  source=console
INFO[0154] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-238, error: failed commit on ref "config-sha256:9bbdcbb3a9b30a8e252efc08fd1060c5f677412d88255209f7b92e7bce3d7ea0": unexpected status: 404 Not Found  source=console
INFO[0154] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-239, error: failed commit on ref "config-sha256:7e4971053ca08ab396992c5224de2dce4754d16c6a78dcbd212debddb0dfb591": unexpected status: 404 Not Found  source=console
INFO[0155] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-240, error: failed commit on ref "config-sha256:63aedcaa6b309a44e1f42511053121b3e4c4f4d3a90aa86cd8839d17cac650c4": unexpected status: 404 Not Found  source=console
INFO[0155] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-241, error: failed commit on ref "config-sha256:87b87ffd059f6c30effebd518599ea55168bec6d161f7121352dc9cb1dd7cb41": unexpected status: 404 Not Found  source=console
INFO[0156] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-242, error: failed commit on ref "config-sha256:73d56714baf7ed0468b13fcd18a9ad6a18cd06da12f30405e94791f108724de6": unexpected status: 404 Not Found  source=console
INFO[0156] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-243, error: failed commit on ref "config-sha256:3880cabb544157b6c90340f77bdd9b2c3957e1032325a414284ee2a897ad6388": unexpected status: 404 Not Found  source=console
INFO[0157] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-244, error: failed commit on ref "config-sha256:f18915e2886c026fa04edebcea000bccd5336f93981add62b7d848412214a537": unexpected status: 404 Not Found  source=console
INFO[0157] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-245, error: failed commit on ref "config-sha256:70dbe240d556fcb5190681ba39538d6112b56ab65e17f50e11c746a41516c4f2": unexpected status: 404 Not Found  source=console
INFO[0158] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-246, error: failed commit on ref "config-sha256:0b149e18d7a0f33b92af8a83fd7ce3ff211806af7aedd574a8e49097aaf511d5": unexpected status: 404 Not Found  source=console
INFO[0158] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-247, error: failed commit on ref "config-sha256:66599c85a586625ad7a32b3f7fd2a021177e1b580cf5e16ec032bc9bc117f580": unexpected status: 404 Not Found  source=console
INFO[0158] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-248, error: failed commit on ref "config-sha256:f0247079e72199b9be25917c23477ad91dff8bd6ae2dc97e6d31b0be104a19d8": unexpected status: 404 Not Found  source=console
INFO[0159] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-249, error: failed commit on ref "config-sha256:18352574bfe81d1a4de0378d6ac8e008335baea05a9445485654e28da610e11a": unexpected status: 404 Not Found  source=console
INFO[0159] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-250, error: failed commit on ref "config-sha256:6f095563e710fae5d6fb8fe496f6df14ab31a1a91bfb9752eef2732259e346ba": unexpected status: 404 Not Found  source=console
INFO[0160] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-251, error: failed commit on ref "config-sha256:f556a4b17c202aed926587c0b5e4be7e73de1da1d6c6cd102cd7f31f78e5bcfc": unexpected status: 404 Not Found  source=console
INFO[0160] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-252, error: failed commit on ref "config-sha256:e0b118c3675073840ebf3a6390f277f352ef432289b64d1a2263ac647615944f": unexpected status: 404 Not Found  source=console
INFO[0161] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-253, error: failed commit on ref "config-sha256:fc59ffea1d7146469c8ba779683738e321e1d567e455cb2bae781149ea1f5cf2": unexpected status: 404 Not Found  source=console
INFO[0161] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-254, error: failed commit on ref "config-sha256:9b8bddb7c0efed5e699afa6f772fd54de8dd269f62fc57c64b598cba23653ddd": unexpected status: 404 Not Found  source=console
INFO[0162] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-255, error: failed commit on ref "config-sha256:1b37a98d6104238ca1ebf7d9208e6c9af02204873678e00b295276142a25ebe0": unexpected status: 404 Not Found  source=console
INFO[0162] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-256, error: failed commit on ref "config-sha256:f7787f8d9eaf17e380365740dad799fe27bd370c282d4675e345a6066f96d1f4": unexpected status: 404 Not Found  source=console
INFO[0162] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-257, error: failed commit on ref "config-sha256:c41500dd9206795d9d44f846f71f482c3b242e7241c7652c504fff477b66a2cd": unexpected status: 404 Not Found  source=console
INFO[0163] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-258, error: failed commit on ref "config-sha256:ae858e363104d07ca682d39714060ba670f5d7f53c9865d0af09747f097544a2": unexpected status: 404 Not Found  source=console
INFO[0163] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-259, error: failed commit on ref "config-sha256:947641681e241b2f53220894340fd4ae0918fcbb1e0cf5b32273de6fb4857867": unexpected status: 404 Not Found  source=console
INFO[0164] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-260, error: failed commit on ref "config-sha256:8fec6a687304a6c30f9e41cd8eab4d8b6fec38509ea9d2c9fa504255feeb3b38": unexpected status: 404 Not Found  source=console
INFO[0164] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-261, error: failed commit on ref "config-sha256:3731ab3120d0634896acf533109168cec0b7956469b17daa3719d42f289322d0": unexpected status: 404 Not Found  source=console
INFO[0165] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-262, error: failed commit on ref "config-sha256:135275294d22f5bb8c127a413c698df16fc97c962f8c23ac98214eec949b2e99": unexpected status: 404 Not Found  source=console
INFO[0165] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-263, error: failed commit on ref "config-sha256:0bcac9c42d8cc016d4f2a5c0c50a42554441a928c5e512484e6470257f008743": unexpected status: 404 Not Found  source=console
INFO[0166] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-264, error: failed commit on ref "config-sha256:926521461b75311873c5678349b16e05e22a60859bffc6ecf5495b194ac52400": unexpected status: 404 Not Found  source=console
INFO[0166] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-265, error: failed commit on ref "config-sha256:5631ea43d87b2612ef12d6c9e4ce59745ec9d019db216334730eb6a1a8ca7a0c": unexpected status: 404 Not Found  source=console
INFO[0167] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-266, error: failed commit on ref "config-sha256:194f1dd27305205c0465728f118cb16381cf69789322b943e27fa7179a23eaa9": unexpected status: 404 Not Found  source=console
INFO[0167] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-267, error: failed commit on ref "config-sha256:02788b03ffb0c7a84ce1b5ce6c480217050a67780c5720341fbe0892a49038aa": unexpected status: 404 Not Found  source=console
INFO[0167] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-268, error: failed commit on ref "config-sha256:6183d7dfc1f2221d886afcc68a66a1612da8bc9f6e4457b7b733eb8544fe0940": unexpected status: 404 Not Found  source=console
INFO[0168] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-269, error: failed commit on ref "config-sha256:972ae34d526a9b9d1dc4f473e88dbeacf84334d20fa7b5f8929ccd93ab3c0581": unexpected status: 404 Not Found  source=console
INFO[0168] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-270, error: failed commit on ref "config-sha256:e43bd50b7662c384e5fb99980dbeb54a12549642d3fe3ed28ed5ae75ea358e05": unexpected status: 404 Not Found  source=console
INFO[0169] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-271, error: failed commit on ref "config-sha256:58682e6aa135949c8d476be9a9eaf6b2c674ee0d8f97a7dd33bbc0b09ec1e332": unexpected status: 404 Not Found  source=console
INFO[0169] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-272, error: failed commit on ref "config-sha256:2f352d7c29fabe573cb2679760e635d69ae5eb87dff35e8dfa22546747f4fe08": unexpected status: 404 Not Found  source=console
INFO[0170] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-273, error: failed commit on ref "config-sha256:9e79daad45770661492356914c0a081f7c2970407c8bfa1b65feb63f758494f2": unexpected status: 404 Not Found  source=console
INFO[0170] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-274, error: failed commit on ref "config-sha256:83d5f24be2b9ce9fb879e3d9e032029ce865e7b289764488333fedf109d72042": unexpected status: 404 Not Found  source=console
INFO[0171] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-275, error: failed commit on ref "config-sha256:b63d44638e19715ab3ea6d0f5646d69cb2b37a1469df5ae7a9583a2a61d6f7b7": unexpected status: 404 Not Found  source=console
INFO[0171] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-276, error: failed commit on ref "config-sha256:2c2889a2417d4b14cb54afca8314fed5fec43f7c191694814764cc5cfe9a32e5": unexpected status: 404 Not Found  source=console
INFO[0172] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-277, error: failed commit on ref "config-sha256:674c8bb25a3d7777fd96f7d280e9992a78d2613da0d3a142e3319a85a82b213e": unexpected status: 404 Not Found  source=console
INFO[0172] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-278, error: failed commit on ref "config-sha256:b349143243ba0c26d3ab0766061887cfc0aa546671c946ad4bdb3883892f0477": unexpected status: 404 Not Found  source=console
INFO[0173] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-279, error: failed commit on ref "config-sha256:8a0a32e07491d13b265d5228fad5d0edfef97912150e5190b593db071ad343f3": unexpected status: 404 Not Found  source=console
INFO[0173] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-280, error: failed commit on ref "config-sha256:e5950218b2c1de319a4dcdd29e34a268116c96fc84f4dcd1c31b145d0dd2ad57": unexpected status: 404 Not Found  source=console
INFO[0173] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-281, error: failed commit on ref "config-sha256:dc957e36c654b7e7963e07f32a382762bd37e815152dbbc0b016693f79f05b69": unexpected status: 404 Not Found  source=console
INFO[0174] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-282, error: failed commit on ref "config-sha256:8b702cc16276fe7e8409a712264564fe0e7a925616d9a27f2da5dbc19f202031": unexpected status: 404 Not Found  source=console
INFO[0174] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-283, error: failed commit on ref "config-sha256:7b1c461b82306970c18f541b9a9b68811121d48edad3fb9437e8ba0963cf54f7": unexpected status: 404 Not Found  source=console
INFO[0175] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-284, error: failed commit on ref "config-sha256:a7a310b231b0c4200f3a02c37c52bef6db6d890a948841cb92e9bfc8d36c9df6": unexpected status: 404 Not Found  source=console
INFO[0175] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-285, error: failed commit on ref "config-sha256:651afca97c1313dd1c653cc3b72a3a652367f8427c3d98aa54e85b2c799c3300": unexpected status: 404 Not Found  source=console
INFO[0176] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-286, error: failed commit on ref "config-sha256:a349f165eb24fbf96323d9417348aec3894fb9f7154e8d5518bbb5bbf6c5bdb9": unexpected status: 404 Not Found  source=console
INFO[0176] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-287, error: failed commit on ref "config-sha256:0f642c821c5e75953d5887cbcc9a42093c51226e7c37b9f15df96548e5615ed1": unexpected status: 404 Not Found  source=console
INFO[0176] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-288, error: failed commit on ref "config-sha256:521fe74fd3125ffcba3057a134a4c888597e885de4795abf216b5943f53c82a7": unexpected status: 404 Not Found  source=console
INFO[0177] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-289, error: failed commit on ref "config-sha256:ce7a6543588684ae7b8dfc108c9f9ce2398ffde9813ad015043dcd2e22a96d04": unexpected status: 404 Not Found  source=console
INFO[0177] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-290, error: failed commit on ref "config-sha256:22dc0a2fad2002eda05a0ad32990cce250fc8f4c6904cb287082c744471f11e0": unexpected status: 404 Not Found  source=console
INFO[0178] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-291, error: failed commit on ref "config-sha256:07fc34918ec39b337b55a73e7e52de709dbfcdaf3ed8563bf7a4c757cf084a5f": unexpected status: 404 Not Found  source=console
INFO[0178] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-292, error: failed commit on ref "config-sha256:a5971868c363c040571f790f9c1ab17639aa3b4133ca6825da352c84d2feb687": unexpected status: 404 Not Found  source=console
INFO[0179] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-293, error: failed commit on ref "config-sha256:e3906a36fd3963681d960f341ecd8be627d6b4b018962782d507f0161fecdff5": unexpected status: 404 Not Found  source=console
INFO[0179] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-294, error: failed commit on ref "config-sha256:58ce08671f8b6fd0a88a4e1989192c343dd3d5be9d62d955a51c3d5948758ee2": unexpected status: 404 Not Found  source=console
INFO[0180] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-295, error: failed commit on ref "config-sha256:f65722f4d9941565983f35c70d923b604f53d98f8a170d9882973671151f7deb": unexpected status: 404 Not Found  source=console
INFO[0180] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-214, error: failed commit on ref "config-sha256:17a4110766cdf39d83d04d4bd91a77699154e118e6360412941c829fb0f510cf": unexpected status: 404 Not Found  source=console
INFO[0180] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-296, error: failed commit on ref "config-sha256:e678b59575523067a36bc509632aea7d7c543c2686301859dbfeb548cf5a8a47": unexpected status: 404 Not Found  source=console
INFO[0180] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-215, error: failed commit on ref "config-sha256:ee13e0385b318b7f2627bd1c38e82f0fe7d8c4bf2e2d6c08e445ee19f489df61": unexpected status: 404 Not Found  source=console
INFO[0180] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-216, error: failed commit on ref "config-sha256:d66268ab773626bbd3651f6456ad12a7ef1446602c1d19d4f0202e33819b5019": unexpected status: 404 Not Found  source=console
INFO[0180] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-217, error: failed commit on ref "config-sha256:0ee7b7bd7d696ec433c968a0f69c27a4eb4a129e9dea78f537ac401d6f050277": unexpected status: 404 Not Found  source=console
INFO[0180] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-218, error: failed commit on ref "config-sha256:1c0f03c7eec200cdf6ac023a5befa68de2415882249b57cc4a3049d7d345e947": unexpected status: 404 Not Found  source=console
INFO[0180] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-221, error: failed commit on ref "config-sha256:6c9d48093b61487a2b70f328246259ccbeadd5e5b50e10c842f1ca6775fa4659": unexpected status: 404 Not Found  source=console
INFO[0181] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-297, error: failed commit on ref "config-sha256:f681eac0367482508505a56732326751f145984461bf997f24a18e76d2596f17": unexpected status: 404 Not Found  source=console
INFO[0181] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-298, error: failed commit on ref "config-sha256:0448806d11ebf97f3f1da94c4aa07d6f2d289d9d524d37ec6bf592aa8c7a36d7": unexpected status: 404 Not Found  source=console
INFO[0181] GoError: failed to push core.harbor-test-s3-kaxj0v7b.dev.banzaicloud.io/project-053/repository-1632418920246:tag-299, error: failed commit on ref "config-sha256:798e5cea129df395fd977047969685e28705e85e5217597275fdef3db339f572": unexpected status: 404 Not Found  source=console

running (04m05.3s), 000/200 VUs, 400 complete and 0 interrupted iterations
default ✓ [======================================] 200 VUs  02m48.9s/10m0s  400/400 shared iters
ERRO[0246] GoError: failed to delete artifact project-053/repository-1632418920246:tag-200, error: artifact project-053/repository-1632418920246:tag-200 not found
        at go.k6.io/k6/js/common.Bind.func1 (native)
        at teardown (file:///home/ubuntu/perf/scripts/test/push-artifacts-to-same-project.js:73:1090(35))  hint="script exception"
Error: running "k6 run scripts/test/push-artifacts-to-same-project.js --no-usage-report --out csv=./outputs/push-artifacts-to-same-project.csv --out json=./outputs/push-artifacts-to-same-project.json --tag script=push-artifacts-to-same-project --vus 200 --iterations 400" failed with exit code 107
exit status 107
```

See the [outputs/](outputs/) directory.


## Logs

See the [logs/](logs/) directory.
